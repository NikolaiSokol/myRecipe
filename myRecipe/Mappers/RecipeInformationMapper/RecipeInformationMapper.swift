//
//  RecipeInformationMapper.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

final class RecipeInformationMapper {
    private func map(_ apiResponse: [RecipeResponse]) -> [Recipe] {
        apiResponse.map {
            map($0)
        }
    }
    
    private func map(_ apiResponse: RecipeResponse) -> Recipe {
        Recipe(
            id: apiResponse.id,
            title: apiResponse.title,
            imageUrl: URL(string: apiResponse.image ?? ""),
            summary: apiResponse.summary.removeHtmlTags(),
            readyInMinutes: String(apiResponse.readyInMinutes) + String(localized: .min),
            servings: String(apiResponse.servings) + String(localized: .serving),
            cuisines: apiResponse.cuisines,
            dishTypes: apiResponse.dishTypes,
            steps: map(apiResponse.analyzedInstructions),
            ingredients: map(apiResponse.extendedIngredients),
            nutrients: map(apiResponse.nutrition)
        )
    }
    
    private func map(_ apiResponse: [AnalyzedInstructionsResponse]) -> [RecipeInstructionStep] {
        guard let response = apiResponse.first else {
            return []
        }
            
        return map(response.steps)
    }
    
    private func map(_ apiResponse: [AnalyzedInstructionsStepResponse]) -> [RecipeInstructionStep] {
        apiResponse.map {
            RecipeInstructionStep(
                number: $0.number,
                text: $0.step,
                ingredients: map($0.ingredients)
            )
        }
    }
    
    private func map(_ apiResponse: [IngredientResponse]?) -> [RecipeIngredient] {
        apiResponse?.map {
            RecipeIngredient(
                id: $0.id,
                name: $0.name,
                imageUrl: URL(string: ApiConstants.ingredientImageUrl + ($0.image ?? "")),
                measures: map($0.measures)
            )
        } ?? []
    }
    
    private func map(_ apiResponse: MeasuresResponse?) -> Measures? {
        apiResponse.map {
            Measures(
                us: map($0.us),
                metric: map($0.metric)
            )
        }
    }
    
    private func map(_ apiResponse: MeasureResponse) -> Measure {
        Measure(
            amount: apiResponse.amount,
            unitShort: apiResponse.unitShort
        )
    }
    
    private func map(_ apiResponse: NutritionResponse?) -> [Nutrient] {
        var nutrients = apiResponse?.nutrients.map {
            Nutrient(
                name: $0.name,
                amount: String($0.amount),
                unit: $0.unit,
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

extension RecipeInformationMapper: RecipeInformationMapping {
    func map(apiResponse: RecipesResponse) -> [Recipe] {
        map(apiResponse.recipes)
    }
    
    func map(apiResponse: RecipeResponse) -> Recipe {
        map(apiResponse)
    }
    
    func map(apiResponse: [RecipeResponse]) -> [Recipe] {
        map(apiResponse)
    }
}
