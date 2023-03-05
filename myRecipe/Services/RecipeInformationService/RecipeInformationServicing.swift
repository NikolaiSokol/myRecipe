//
//  RecipeInformationServicing.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

protocol RecipeInformationServicing {
    func loadRecipeInfo(id: Int) async throws -> Recipe
}
