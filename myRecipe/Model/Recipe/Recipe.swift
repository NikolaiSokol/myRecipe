//
//  Recipe.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 12.07.2021.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let servings: Int
    let readyInMinutes: Int
    let instructions: String
    let dishTypes: [String]
    let extendedIngredients: [ExtendedIngredients]
    let nutrition: Nutrition
    let sourceName: String
    let sourceUrl: String
}
