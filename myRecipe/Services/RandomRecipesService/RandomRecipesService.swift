//
//  RandomRecipesService.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class RandomRecipesService {
    private let urlBuilder: URLBuilding
    private let requestBuilder: URLRequestBuilding
    private let recipeInformationMapper: RecipeInformationMapping
    
    init(
        urlBuilder: URLBuilding,
        requestBuilder: URLRequestBuilding,
        recipeInformationMapper: RecipeInformationMapping
    ) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
        self.recipeInformationMapper = recipeInformationMapper
    }
}

extension RandomRecipesService: RandomRecipesServicing {
    func loadWithType(_ type: String, number: Int) async throws -> [RecipeInformation] {
        let url = try urlBuilder.buildURL(methodPath: .random)
        let query = RandomRecipesQuery(tags: type, number: number)
        let request = try requestBuilder.buildURLRequest(url: url, query: query, method: .get)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let recipes = try JSONDecoder().decode(RecipesResponse.self, from: data)
        
        return recipeInformationMapper.map(apiResponse: recipes)
    }
}
