//
//  AnalyzedInstructionsStepResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

struct AnalyzedInstructionsStepResponse: Codable {
    let number: Int
    let step: String
    let ingredients: [IngredientResponse]
}
