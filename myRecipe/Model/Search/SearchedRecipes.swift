//
//  SearchedRecipes.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import Foundation

struct SearchedRecipes: Codable {
    let results: [SearchedRecipe]
    let totalResults: Int
}
