//
//  URL+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

extension URL {
    func appendedURL(queryItems appendQueryItems: [URLQueryItem]) throws -> URL {
        if appendQueryItems.isEmpty {
            return self
        }

        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            throw URLError.cannotBeFormed
        }

        var newQueryItemsList = components.queryItems

        if newQueryItemsList == nil {
            newQueryItemsList = [URLQueryItem]()
        }

        newQueryItemsList?.append(contentsOf: appendQueryItems)

        components.queryItems = newQueryItemsList

        guard let appendedURL = components.url else {
            throw URLError.cannotBeFormed
        }

        return appendedURL
    }
}
