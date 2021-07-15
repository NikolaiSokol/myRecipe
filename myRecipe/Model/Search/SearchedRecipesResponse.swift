//
//  SearchedRecipesResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import Foundation

struct SearchedRecipesResponse: Codable {
    let results: [SearchedRecipe]
    let totalResults: Int
}
