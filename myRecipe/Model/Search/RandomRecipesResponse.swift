//
//  RandomRecipesResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import Foundation

struct RandomRecipesResponse: Codable {
    let recipes: [SearchedRecipe]
}
