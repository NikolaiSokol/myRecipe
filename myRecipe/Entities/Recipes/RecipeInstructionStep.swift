//
//  RecipeInstructionStep.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

struct RecipeInstructionStep: Equatable {
    let number: Int
    let text: String
    let ingredients: [RecipeIngredient]
}
