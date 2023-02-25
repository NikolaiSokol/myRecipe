//
//  RandomRecipesServicing.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

protocol RandomRecipesServicing {
    func loadWithType(_ type: String, number: Int) async throws -> [Recipe]
}
