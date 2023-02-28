//
//  SearchService.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

final class SearchService {
    private let urlBuilder: URLBuilding
    private let requestBuilder: URLRequestBuilding
    private let searchMapper: SearchMapping
    
    init(
        urlBuilder: URLBuilding,
        requestBuilder: URLRequestBuilding,
        searchMapper: SearchMapping
    ) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
        self.searchMapper = searchMapper
    }
}

extension SearchService: SearchServicing {
    func search(params: SearchParameters) async throws -> SearchResults {
        let url = try urlBuilder.buildURL(methodPath: .search)
        let query = SearchQuery(params: params)
        let request = try requestBuilder.buildURLRequest(url: url, query: query, method: .get)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let results = try JSONDecoder().decode(SearchResultsResponse.self, from: data)
        
        return searchMapper.map(apiResponse: results)
    }
    
    func loadAutocomplete(query: String, number: Int) async throws -> [SearchAutocomplete] {
        let url = try urlBuilder.buildURL(methodPath: .autocomplete)
        let query = AutocompleteQuery(query: query, number: number)
        let request = try requestBuilder.buildURLRequest(url: url, query: query, method: .get)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([SearchAutocompleteResponse].self, from: data)
        
        return searchMapper.map(apiResponse: result)
    }
}
