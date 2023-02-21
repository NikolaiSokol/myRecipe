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
    
    private(set) lazy var searchService: SearchServicing = SearchService(
        urlBuilder: urlBuilder,
        requestBuilder: requestBuilder,
        recipeInformationMapper: recipeInformationMapper
    )
}
