//
//  Recipe.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

struct Recipe {
    let id: Int
    let title: String
    let imageUrl: URL?
    let summary: String
    let readyInMinutes: String
    let servings: String
    let cuisines: [String]
    let dishTypes: [String]
    let steps: [RecipeInstructionStep]
    let ingredients: [RecipeIngredient]
    
    static var empty: Recipe {
        Recipe(
            id: 0,
            title: "",
            imageUrl: nil,
            summary: "",
            readyInMinutes: "",
            servings: "",
            cuisines: [],
            dishTypes: [],
            steps: [],
            ingredients: []
        )
    }
}
