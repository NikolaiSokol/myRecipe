//
//  Nutrition.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 12.07.2021.
//

import Foundation

struct Nutrition: Decodable {
    let nutrients: [Nutrients]
    let caloricBreakdown: CaloricBreakdown
    let weightPerServing: WeightPerServing
}
