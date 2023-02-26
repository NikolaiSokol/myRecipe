//
//  Nutrient.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

struct Nutrient: Identifiable {
    let id = UUID()
    let name: String
    let amount: String
    let unit: String
    let percentOfDailyNeeds: Double
}
