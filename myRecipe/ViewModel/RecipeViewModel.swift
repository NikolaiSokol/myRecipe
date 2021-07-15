//
//  RecipeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 04.07.2021.
//

import UIKit
import CoreData

final class RecipeViewModel {
    
    private let queue = DispatchQueue(label: "RecipeViewModelQueue", attributes: .concurrent)
    private let recipeManager = RecipeNetworkManager()
    private let imageLoader: ImageLoadingManager
    private let coreDataStack: CoreDataStack
    private let recipeId: Int
    private let coreDataRecipe: RecipeCoreData?
    
    private var isLoading = false {
        didSet {
            showingSpinner?(isLoading)
        }
    }
    
    var recipe: Recipe? {
        didSet {
            recipeLoaded?()
        }
    }
    
    var recipeLoaded: (() -> Void)?
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
        if coreDataRecipe == nil {
            loadRecipeFromNetwork()
        } else {
            queue.async { [weak self] in
                self?.makeRecipeFromCoreData()
            }
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
    
    private func makeRecipeFromCoreData() {
        if let coreDataRecipe = coreDataRecipe {
            let coreDataExtendedIngredients = coreDataRecipe.extendedIngredients?.allObjects as? [ExtendedIngredientsCoreData]
            let coreDataNutrients = coreDataRecipe.nutrition.nutrients?.allObjects as? [NutrientsCoreData]
            
            var extendedIngredients = [ExtendedIngredients]()
            var nutrients = [Nutrients]()
            
            coreDataExtendedIngredients?.forEach {
                let ingredient = ExtendedIngredients(
                    name: $0.name,
                    id: Int($0.id),
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
    
    func saveToCoreData() {
        if let recipe = recipe {
            coreDataStack.saveRecipe(recipe)
        }
    }
    
    // MARK: - Image
    
    func loadMainImage(completion: @escaping (UIImage) -> Void) {
        guard let recipe = recipe else {
            errorOccured?()
            return
        }
        
        imageLoader.loadImage(imageUrl: recipe.image) { result in
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
