//
//  Measures.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

struct Measures {
    let us: Measure
    let metric: Measure
}

struct Measure {
    let amount: Double
    let unitShort: String
}
