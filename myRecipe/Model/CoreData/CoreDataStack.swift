//
//  CoreDataStack.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.07.2021.
//

import Foundation
import CoreData

final class CoreDataStack {

    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "myRecipe")
        container.loadPersistentStores { _, error in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        return container
    }()
    
    lazy var backgroundContext = container.newBackgroundContext()
    
    var viewContext: NSManagedObjectContext { container.viewContext }
    
    func saveRecipe(_ recipe: Recipe) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            let coreDataRecipe = RecipeCoreData(context: self.backgroundContext)
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
                let extendedIngredient = ExtendedIngredientsCoreData(context: self.backgroundContext)
                extendedIngredient.id = Int64($0.id)
                extendedIngredient.image = $0.image
                extendedIngredient.name = $0.name
                
                let metricMeasure = MetricCoreData(context: self.backgroundContext)
                metricMeasure.amount = $0.measures.metric.amount
                metricMeasure.unitLong = $0.measures.metric.unitLong
                
                let usMeasure = MetricCoreData(context: self.backgroundContext)
                usMeasure.amount = $0.measures.us.amount
                usMeasure.unitLong = $0.measures.us.unitLong
                
                let measures = MeasuresCoreData(context: self.backgroundContext)
                measures.metric = metricMeasure
                measures.us = usMeasure
                
                extendedIngredient.measures = measures
                
                coreDataRecipe.addToExtendedIngredients(extendedIngredient)
            }
            
            let nutrition = NutritionCoreData(context: self.backgroundContext)
            
            recipe.nutrition.nutrients.forEach {
                let nutrient = NutrientsCoreData(context: self.backgroundContext)
                nutrient.amount = $0.amount
                nutrient.name = $0.name
                nutrient.percentOfDailyNeeds = $0.percentOfDailyNeeds
                nutrient.unit = $0.unit
                
                nutrition.addToNutrients(nutrient)
            }
            
            let caloricBreakdown = CaloricBreakdownCoreData(context: self.backgroundContext)
            caloricBreakdown.percentProtein = recipe.nutrition.caloricBreakdown.percentProtein
            caloricBreakdown.percentFat = recipe.nutrition.caloricBreakdown.percentFat
            caloricBreakdown.percentCarbs = recipe.nutrition.caloricBreakdown.percentCarbs
            nutrition.caloricBreakdown = caloricBreakdown
            
            let weightPerServing = WeightPerServingCoreData(context: self.backgroundContext)
            weightPerServing.amount = Int64(recipe.nutrition.weightPerServing.amount)
            weightPerServing.unit = recipe.nutrition.weightPerServing.unit
            nutrition.weightPerServing = weightPerServing
            
            coreDataRecipe.nutrition = nutrition
            
            self.saveContext(context: self.backgroundContext)
        }
    }
    
    private func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }
}
