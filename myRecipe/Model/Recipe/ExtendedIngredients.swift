//
//  ExtendedIngredients.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 12.07.2021.
//

import Foundation

struct ExtendedIngredients: Decodable {
    let name: String
    let id: Int
    let image: String
    let measures: Measures
}
