//
//  SearchResultsResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

struct SearchResultsResponse: Codable {
    let results: [RecipeResponse]
    let offset: Int
    let totalResults: Int
}
