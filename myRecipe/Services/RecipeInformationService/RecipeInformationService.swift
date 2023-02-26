//
//  RecipeInformationService.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

final class RecipeInformationService {
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

extension RecipeInformationService: RecipeInformationServicing {
    func loadNutrients(id: Int) async throws -> [Nutrient] {
        let url = try urlBuilder.buildURL(methodPath: .recipeInformation(id))
        let query = RecipeInformationQuery(includeNutrition: true)
        let request = try requestBuilder.buildURLRequest(url: url, query: query, method: .get)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let recipe = try JSONDecoder().decode(RecipeResponse.self, from: data)
        
        return recipeInformationMapper.map(apiResponse: recipe)
    }
}
