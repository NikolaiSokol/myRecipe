//
//  URLRequestBuilding.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

protocol URLRequestBuilding {
    func buildURLRequest(
        url: URL,
        query: QueryItemsRepresentable?,
        method: HTTPMethod
    ) throws -> URLRequest
}
