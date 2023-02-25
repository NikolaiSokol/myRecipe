//
//  MeasuresResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

struct MeasuresResponse: Codable {
    let us: MeasureResponse
    let metric: MeasureResponse
}

struct MeasureResponse: Codable {
    let amount: Double
    let unitShort: String
}
