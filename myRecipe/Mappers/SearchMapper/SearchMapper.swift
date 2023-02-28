//
//  SearchMapper.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

final class SearchMapper {
    private let recipeInformationMapper: RecipeInformationMapping
    
    init(recipeInformationMapper: RecipeInformationMapping) {
        self.recipeInformationMapper = recipeInformationMapper
    }
}

extension SearchMapper: SearchMapping {
    func map(apiResponse: SearchResultsResponse) -> SearchResults {
        SearchResults(
            recipes: recipeInformationMapper.map(apiResponse: apiResponse.results),
            offset: apiResponse.offset,
            totalResults: apiResponse.totalResults
        )
    }
    
    func map(apiResponse: [SearchAutocompleteResponse]) -> [SearchAutocomplete] {
        apiResponse.map {
            SearchAutocomplete(id: $0.id, text: $0.title)
        }
    }
}
