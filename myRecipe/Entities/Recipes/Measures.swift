//
//  Measures.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

struct Measures: Equatable {
    let us: Measure
    let metric: Measure
}

struct Measure: Equatable {
    let amount: Double
    let unitShort: String
}
