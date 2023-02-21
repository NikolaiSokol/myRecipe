//
//  SearchService.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

struct SearchService {
    let urlBuilder = URLBuilder()
    let requestBuilder = URLRequestBuilder()
    
    func load() async throws -> Data {
        let (data, _) = try await URLSession.shared.data(
            for: requestBuilder.buildURLRequest(
                url: urlBuilder.buildURL(methodPath: .search),
                query: SearchQuery(query: "pasta", offset: 0, number: 5),
                method: .get
            )
        )
        
        return data
    }
}
