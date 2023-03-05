//
//  PersistentMapper.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//

import Foundation
import CoreData

final class PersistentMapper {
    // MARK: - To CoreDate
    
    private func map(
        _ step: RecipeInstructionStep,
        context: NSManagedObjectContext
    ) -> RecipeInstructionStepEntity {
        let stepEntity = RecipeInstructionStepEntity(context: context)
        
        stepEntity.number = Int64(step.number)
        stepEntity.text = step.text
        step.ingredients.forEach {
            stepEntity.addToIngredients(map($0, context: context))
        }
        
        return stepEntity
    }
    
    private func map(
        _ ingredient: RecipeIngredient,
        context: NSManagedObjectContext
    ) -> RecipeIngredientEntity {
        let ingredientEntity = RecipeIngredientEntity(context: context)
        
        ingredientEntity.id = Int64(ingredient.id)
        ingredientEntity.name = ingredient.name
        ingredientEntity.imageUrl = ingredient.imageUrl?.absoluteString
        
        if let measures = ingredient.measures {
            ingredientEntity.measures = map(measures, context: context)
        }
        
        return ingredientEntity
    }
    
    private func map(
        _ measures: Measures,
        context: NSManagedObjectContext
    ) -> MeasuresEntity {
        let measuresEntity = MeasuresEntity(context: context)
        
        measuresEntity.us = map(measures.us, context: context)
        measuresEntity.metric = map(measures.metric, context: context)
        
        return measuresEntity
    }
    
    private func map(
        _ measure: Measure,
        context: NSManagedObjectContext
    ) -> MeasureEntity {
        let measureEntity = MeasureEntity(context: context)
        
        measureEntity.amount = measure.amount
        measureEntity.unitShort = measure.unitShort
        
        return measureEntity
    }
    
    private func map(
        _ nutrient: Nutrient,
        context: NSManagedObjectContext
    ) -> NutrientEntity {
        let nutrientEntity = NutrientEntity(context: context)
        
        nutrientEntity.id = nutrient.id
        nutrientEntity.name = nutrient.name
        nutrientEntity.amount = nutrient.amount
        nutrientEntity.unit = nutrient.unit
        
        if let percent = nutrient.percentOfDailyNeeds {
            nutrientEntity.percentOfDailyNeeds = percent
        }
        
        return nutrientEntity
    }
    
    // MARK: - From CoreData
    
    private func map(_ entities: [RecipeInstructionStepEntity]?) -> [RecipeInstructionStep] {
        entities?
            .sorted { $0.number < $1.number }
            .map {
                RecipeInstructionStep(
                    number: Int($0.number),
                    text: $0.text ?? "",
                    ingredients: map($0.ingredients?.allObjects as? [RecipeIngredientEntity])
                )
            } ?? []
    }
    
    private func map(_ entities: [RecipeIngredientEntity]?) -> [RecipeIngredient] {
        entities?
            .sorted { $0.name ?? "" < $1.name ?? "" }
            .map {
                RecipeIngredient(
                    id: Int($0.id),
                    name: $0.name ?? "",
                    imageUrl: URL(string: $0.imageUrl ?? ""),
                    measures: map($0.measures)
                )
            } ?? []
    }
    
    private func map(_ entity: MeasuresEntity?) -> Measures? {
        guard let us = entity?.us,
              let metric = entity?.metric
        else {
            return nil
        }
        
        return Measures(
            us: map(us),
            metric: map(metric)
        )
    }
    
    private func map(_ entity: MeasureEntity) -> Measure {
        Measure(
            amount: entity.amount,
            unitShort: entity.unitShort ?? ""
        )
    }
    
    private func map(_ entities: [NutrientEntity]?) -> [Nutrient] {
        var nutrients = entities?.map {
            Nutrient(
                name: $0.name ?? "",
                amount: $0.amount ?? "",
                unit: $0.unit ?? "",
                percentOfDailyNeeds: $0.percentOfDailyNeeds
            )
        } ?? []
        
        rearrangeNutrients(&nutrients)
        
        return nutrients
    }
    
    private func rearrangeNutrients(_ nutrients: inout [Nutrient]) {
        guard !nutrients.isEmpty else {
            return
        }
        
        nutrients.sort { $0.name < $1.name }
        
        if let proteinIndex = nutrients.firstIndex(
            where: { $0.name.lowercased() == BasicNutrientType.protein.rawValue }
        ) {
            nutrients.insert(nutrients.remove(at: proteinIndex), at: 0)
        }
        
        if let fatIndex = nutrients.firstIndex(
            where: { $0.name.lowercased() == BasicNutrientType.fat.rawValue }
        ) {
            nutrients.insert(nutrients.remove(at: fatIndex), at: 0)
        }
        
        if let caloriesIndex = nutrients.firstIndex(
            where: { $0.name.lowercased() == BasicNutrientType.calories.rawValue }
        ) {
            nutrients.insert(nutrients.remove(at: caloriesIndex), at: 0)
        }
    }
}

extension PersistentMapper: PersistentMapping {
    func map(_ recipe: Recipe, context: NSManagedObjectContext) {
        let recipeEntity = RecipeEntity(context: context)
        
        recipeEntity.id = Int64(recipe.id)
        recipeEntity.title = recipe.title
        recipeEntity.imageUrl = recipe.imageUrl?.absoluteString
        recipeEntity.summary = recipe.summary
        recipeEntity.readyInMinutes = recipe.readyInMinutes
        recipeEntity.servings = recipe.servings
        recipeEntity.cuisines = recipe.cuisines
        recipeEntity.dishTypes = recipe.dishTypes
        recipe.steps.forEach {
            recipeEntity.addToSteps(map($0, context: context))
        }
        recipe.ingredients.forEach {
            recipeEntity.addToIngredients(map($0, context: context))
        }
        recipe.nutrients.forEach {
            recipeEntity.addToNutrients(map($0, context: context))
        }
        recipeEntity.savingDate = Date()
    }
    
    func map(entities: [RecipeEntity]) -> [Recipe] {
        entities.map {
            Recipe(
                id: Int($0.id),
                title: $0.title ?? "",
                imageUrl: URL(string: $0.imageUrl ?? ""),
                summary: $0.summary ?? "",
                readyInMinutes: $0.readyInMinutes ?? "",
                servings: $0.servings ?? "",
                cuisines: $0.cuisines ?? [],
                dishTypes: $0.dishTypes ?? [],
                steps: map($0.steps?.allObjects as? [RecipeInstructionStepEntity]),
                ingredients: map($0.ingredients?.allObjects as? [RecipeIngredientEntity]),
                nutrients: map($0.nutrients?.allObjects as? [NutrientEntity])
            )
        }
    }
}
