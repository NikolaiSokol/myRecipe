//
//  SearchedRecipesResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import Foundation

struct SearchedRecipesResponse: Decodable {
    let results: [SearchedRecipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}
