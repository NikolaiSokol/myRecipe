//
//  RecipeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 04.07.2021.
//

import UIKit
import CoreData

final class RecipeViewModel: NSObject, NSFetchedResultsControllerDelegate {
    
    private let queue = DispatchQueue(label: "RecipeViewModelQueue", attributes: .concurrent)
    private let recipeManager = RecipeNetworkManager()
    private let imageLoader: ImageLoadingManager
    private let coreDataStack: CoreDataStack
    private let recipeId: Int
    private let coreDataRecipe: RecipeCoreData?
    
    private lazy var fetchedResultsController: NSFetchedResultsController<RecipeCoreData> = {
        FetchedResultsController.getFetchedResultsController(delegate: self, context: coreDataStack.backgroundContext)
    }()
    
    private var isLoading = false {
        didSet {
            showingSpinner?(isLoading)
        }
    }
    
    var recipe: Recipe? {
        didSet {
            recipeChanged?()
        }
    }
    
    var recipeChanged: (() -> Void)?
    var showingSpinner: ((Bool) -> Void)?
    var errorOccured: (() -> Void)?
    
    init(imageLoader: ImageLoadingManager, coreDataStack: CoreDataStack, recipeId: Int) {
        self.imageLoader = imageLoader
        self.coreDataStack = coreDataStack
        self.recipeId = recipeId
        self.coreDataRecipe = nil
    }
    
    init(imageLoader: ImageLoadingManager, coreDataStack: CoreDataStack, coreDataRecipe: RecipeCoreData) {
        self.imageLoader = imageLoader
        self.coreDataStack = coreDataStack
        self.recipeId = Int(coreDataRecipe.id)
        self.coreDataRecipe = coreDataRecipe
    }
    
    // MARK: - Recipe
    
    func loadRecipe() {
        performFetch()
        
        if coreDataRecipe == nil {
            loadRecipeFromNetwork()
        } else {
            queue.async { [weak self] in
                self?.makeRecipeFromCoreData()
            }
        }
    }
    
    private func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            errorOccured?()
        }
    }
    
    private func loadRecipeFromNetwork() {
        isLoading = true
        recipeManager.loadRecipe(id: recipeId) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let recipe):
                    self?.recipe = recipe
                    self?.isLoading = false
                case .failure:
                    self?.errorOccured?()
                    self?.isLoading = false
                }
            }
        }
    }
    
    // MARK: - Core Data
    
    func isRecipeSaved() -> Bool {
        coreDataStack.isRecipeSaved(id: recipeId)
    }
    
    func saveToCoreData() {
        if let recipe = recipe {
            let context = coreDataStack.backgroundContext
            context.perform { [weak self] in
                let coreDataRecipe = RecipeCoreData(context: context)
                coreDataRecipe.id = Int64(recipe.id)
                coreDataRecipe.title = recipe.title
                coreDataRecipe.image = recipe.image
                coreDataRecipe.dishTypes = recipe.dishTypes
                coreDataRecipe.instructions = recipe.instructions
                coreDataRecipe.readyInMinutes = Int64(recipe.readyInMinutes)
                coreDataRecipe.servings = Int64(recipe.servings)
                coreDataRecipe.sourceName = recipe.sourceName
                coreDataRecipe.sourceUrl = recipe.sourceUrl
                coreDataRecipe.savedDate = Date()
                
                recipe.extendedIngredients.forEach {
                    let extendedIngredient = ExtendedIngredientsCoreData(context: context)
                    extendedIngredient.image = $0.image
                    extendedIngredient.name = $0.name
                    
                    let metricMeasure = MetricCoreData(context: context)
                    metricMeasure.amount = $0.measures.metric.amount
                    metricMeasure.unitLong = $0.measures.metric.unitLong
                    
                    let usMeasure = MetricCoreData(context: context)
                    usMeasure.amount = $0.measures.us.amount
                    usMeasure.unitLong = $0.measures.us.unitLong
                    
                    let measures = MeasuresCoreData(context: context)
                    measures.metric = metricMeasure
                    measures.us = usMeasure
                    
                    extendedIngredient.measures = measures
                    
                    coreDataRecipe.addToExtendedIngredients(extendedIngredient)
                }
                
                let nutrition = NutritionCoreData(context: context)
                
                recipe.nutrition.nutrients.forEach {
                    let nutrient = NutrientsCoreData(context: context)
                    nutrient.amount = $0.amount
                    nutrient.name = $0.name
                    nutrient.percentOfDailyNeeds = $0.percentOfDailyNeeds
                    nutrient.unit = $0.unit
                    
                    nutrition.addToNutrients(nutrient)
                }
                
                let caloricBreakdown = CaloricBreakdownCoreData(context: context)
                caloricBreakdown.percentProtein = recipe.nutrition.caloricBreakdown.percentProtein
                caloricBreakdown.percentFat = recipe.nutrition.caloricBreakdown.percentFat
                caloricBreakdown.percentCarbs = recipe.nutrition.caloricBreakdown.percentCarbs
                nutrition.caloricBreakdown = caloricBreakdown
                
                let weightPerServing = WeightPerServingCoreData(context: context)
                weightPerServing.amount = Int64(recipe.nutrition.weightPerServing.amount)
                weightPerServing.unit = recipe.nutrition.weightPerServing.unit
                nutrition.weightPerServing = weightPerServing
                
                coreDataRecipe.nutrition = nutrition
                
                self?.coreDataStack.saveContext(context: context)
            }
        }
    }
    
    func deleteRecipeFromCoreData() {
        coreDataStack.deleteRecipe(id: recipeId)
    }
    
    private func makeRecipeFromCoreData() {
        if let coreDataRecipe = coreDataRecipe {
            let coreDataExtendedIngredients = coreDataRecipe.extendedIngredients?.allObjects as? [ExtendedIngredientsCoreData]
            let coreDataNutrients = coreDataRecipe.nutrition.nutrients?.allObjects as? [NutrientsCoreData]
            
            var extendedIngredients = [ExtendedIngredients]()
            var nutrients = [Nutrients]()
            
            coreDataExtendedIngredients?.forEach {
                let ingredient = ExtendedIngredients(
                    name: $0.name,
                    image: $0.image,
                    measures: Measures(
                        metric: Metric(amount: $0.measures.metric.amount, unitLong: $0.measures.metric.unitLong),
                        us: Metric(amount: $0.measures.us.amount, unitLong: $0.measures.us.unitLong)
                    )
                )
                
                extendedIngredients.append(ingredient)
            }
            
            coreDataNutrients?.forEach {
                let nutrient = Nutrients(
                    name: $0.name,
                    amount: $0.amount,
                    unit: $0.unit,
                    percentOfDailyNeeds: $0.percentOfDailyNeeds
                )
                
                nutrients.append(nutrient)
            }
            
            let nutrition = Nutrition(
                nutrients: nutrients,
                caloricBreakdown: CaloricBreakdown(
                    percentProtein: coreDataRecipe.nutrition.caloricBreakdown.percentProtein,
                    percentFat: coreDataRecipe.nutrition.caloricBreakdown.percentFat,
                    percentCarbs: coreDataRecipe.nutrition.caloricBreakdown.percentCarbs
                ),
                weightPerServing: WeightPerServing(
                    amount: Int(coreDataRecipe.nutrition.weightPerServing.amount),
                    unit: coreDataRecipe.nutrition.weightPerServing.unit
                )
            )
            
            let newRecipe = Recipe(
                id: Int(coreDataRecipe.id),
                title: coreDataRecipe.title,
                image: coreDataRecipe.image,
                servings: Int(coreDataRecipe.servings),
                readyInMinutes: Int(coreDataRecipe.readyInMinutes),
                instructions: coreDataRecipe.instructions,
                dishTypes: coreDataRecipe.dishTypes,
                extendedIngredients: extendedIngredients,
                nutrition: nutrition,
                sourceName: coreDataRecipe.sourceName,
                sourceUrl: coreDataRecipe.sourceUrl
            )
            
            DispatchQueue.main.async { [weak self] in
                self?.recipe = newRecipe
            }
        }
    }
    
    // MARK: - Fetched Results Controller Delegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async { [weak self] in
            self?.recipeChanged?()
        }
    }
    
    // MARK: - Image
    
    func loadMainImage(completion: @escaping (UIImage) -> Void) {
        guard let recipe = recipe else {
            errorOccured?()
            return
        }
        
        if let image = recipe.image {
            imageLoader.loadImage(imageUrl: image) { result in
                DispatchQueue.main.async {  [weak self] in
                    switch result {
                    case .success(let loadedImage):
                        completion(loadedImage)
                    case .failure:
                        self?.errorOccured?()
                    }
                }
            }
        } else {
            if let noImage = UIImage(named: "noImage") {
                completion(noImage)
            } else {
                errorOccured?()
            }
        }
        
    }
    
    func loadIngredientImage(name: String, completion: @escaping (UIImage) -> Void) {
        imageLoader.loadImage(imageUrl: "https://spoonacular.com/cdn/ingredients_100x100/" + name) { result in
            DispatchQueue.main.async {  [weak self] in
                switch result {
                case .success(let loadedImage):
                    completion(loadedImage)
                case .failure:
                    self?.errorOccured?()
                }
            }
        }
    }
}
