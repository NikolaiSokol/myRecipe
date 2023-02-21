//
//  RecipeInformationMapping.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

protocol RecipeInformationMapping {
    func map(apiResponse: RecipesResponse) -> [RecipeInformation]
}