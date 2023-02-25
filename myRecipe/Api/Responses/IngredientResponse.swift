//
//  IngredientResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

struct IngredientResponse: Codable {
    let id: Int
    let name: String
    let image: String?
    let measures: MeasuresResponse?
}
