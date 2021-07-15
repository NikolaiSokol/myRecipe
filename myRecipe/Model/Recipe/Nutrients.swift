//
//  Nutrients.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.07.2021.
//

import Foundation

struct Nutrients: Codable {
    let name: String
    let amount: Float
    let unit: String
    let percentOfDailyNeeds: Float
}
