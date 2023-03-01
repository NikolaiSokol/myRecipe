//
//  NutrientResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

struct NutrientResponse: Codable {
    let name: String
    let amount: Double
    let unit: String
    let percentOfDailyNeeds: Double?
}
