//
//  RecipeInformationMapper.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

final class RecipeInformationMapper: RecipeInformationMapping {
    func map(apiResponse: RecipesResponse) -> [RecipeInformation] {
        apiResponse.recipes.map {
            RecipeInformation(
                id: $0.id,
                title: $0.title,
                imageUrl: URL(string: $0.image ?? ""),
                readyInMinutes: String($0.readyInMinutes) + " min"
            )
        }
    }
}
