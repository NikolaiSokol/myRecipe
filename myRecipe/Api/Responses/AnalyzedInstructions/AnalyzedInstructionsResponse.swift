//
//  AnalyzedInstructionsResponse.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

struct AnalyzedInstructionsResponse: Codable {
    let steps: [AnalyzedInstructionsStepResponse]
}
