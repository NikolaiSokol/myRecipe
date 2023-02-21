//
//  SearchServicing.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

protocol SearchServicing {
    func loadRandomRecipesWithType(_ type: String, number: Int) async throws -> [RecipeInformation]
}
