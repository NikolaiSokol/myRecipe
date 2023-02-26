//
//  Dependencies.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

final class Dependencies: DependenciesProtocol {
    private lazy var urlBuilder: URLBuilding = URLBuilder()
    private lazy var requestBuilder: URLRequestBuilding = URLRequestBuilder()
    
    private lazy var recipeInformationMapper: RecipeInformationMapping = RecipeInformationMapper()
    
    private(set) lazy var randomRecipesService: RandomRecipesServicing = RandomRecipesService(
        urlBuilder: urlBuilder,
        requestBuilder: requestBuilder,
        recipeInformationMapper: recipeInformationMapper
    )
    
    private(set) lazy var recipeInformationService: RecipeInformationServicing = RecipeInformationService(
        urlBuilder: urlBuilder,
        requestBuilder: requestBuilder,
        recipeInformationMapper: recipeInformationMapper
    )
    
}
