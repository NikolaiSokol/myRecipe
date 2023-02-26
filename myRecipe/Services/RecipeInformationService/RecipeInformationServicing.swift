//
//  RecipeInformationServicing.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

protocol RecipeInformationServicing {
    func loadNutrients(id: Int) async throws -> [Nutrient]
}
