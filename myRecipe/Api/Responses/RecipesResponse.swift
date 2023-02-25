//
//  RecipesResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

struct RecipesResponse: Codable {
    let recipes: [RecipeResponse]
}
