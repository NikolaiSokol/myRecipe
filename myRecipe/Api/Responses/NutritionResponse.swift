//
//  NutritionResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

struct NutritionResponse: Codable {
    let nutrients: [NutrientResponse]
}
