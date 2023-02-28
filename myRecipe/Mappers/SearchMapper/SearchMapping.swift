//
//  SearchMapping.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

protocol SearchMapping {
    func map(apiResponse: SearchResultsResponse) -> SearchResults
    func map(apiResponse: [SearchAutocompleteResponse]) -> [SearchAutocomplete]
}
