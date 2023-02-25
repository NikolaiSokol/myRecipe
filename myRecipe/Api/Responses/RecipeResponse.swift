//
//  RecipeResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

struct RecipeResponse: Codable {
    let id: Int
    let title: String
    let image: String?
    let summary: String
    let readyInMinutes: Int
    let servings: Int
    let cuisines: [String]
    let dishTypes: [String]
    let analyzedInstructions: [AnalyzedInstructionsResponse]
    let extendedIngredients: [IngredientResponse]
}
