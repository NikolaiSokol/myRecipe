//
//  RecipeInformationResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

struct RecipeInformationResponse: Codable {
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int
}
