//
//  URLRequestBuilder.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

struct URLRequestBuilder {
    private let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: ApiConstants.key)
}

extension URLRequestBuilder: URLRequestBuilding {
    func buildURLRequest(
        url: URL,
        query: QueryItemsRepresentable?,
        method: HTTPMethod
    ) throws -> URLRequest {
        var completedURL = url

        if let query = query {
            var items = query.queryItems()
            items.append(apiKeyQueryItem)
            
            completedURL = try url.appendedURL(queryItems: items)
        }
        
        var request = URLRequest(url: completedURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}
