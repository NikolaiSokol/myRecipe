//
//  RecipeIngredient.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

struct RecipeIngredient: Identifiable {
    let id: Int
    let name: String
    let imageUrl: URL?
    let measures: Measures?
}
