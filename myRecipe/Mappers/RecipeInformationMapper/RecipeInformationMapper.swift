//
//  RecipeInformationMapper.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

final class RecipeInformationMapper {
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
    
    private func map(_ apiResponse: [IngredientResponse]) -> [RecipeIngredient] {
        apiResponse.map {
            RecipeIngredient(
                id: $0.id,
                name: $0.name,
                imageUrl: URL(string: ApiConstants.ingredientImageUrl + ($0.image ?? "")),
                measures: map($0.measures)
            )
        }
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
}

extension RecipeInformationMapper: RecipeInformationMapping {
    func map(apiResponse: RecipesResponse) -> [Recipe] {
        apiResponse.recipes.map {
            Recipe(
                id: $0.id,
                title: $0.title,
                imageUrl: URL(string: $0.image ?? ""),
                summary: $0.summary.removeHtmlTags(),
                readyInMinutes: String($0.readyInMinutes) + "min".localized(),
                servings: String($0.servings) + "serving".localized(),
                cuisines: $0.cuisines,
                dishTypes: $0.dishTypes,
                steps: map($0.analyzedInstructions),
                ingredients: map($0.extendedIngredients)
            )
        }
    }
}
