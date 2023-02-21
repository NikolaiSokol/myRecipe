//
//  URLBuilder.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

struct URLBuilder: URLBuilding {
    func buildURL(methodPath: MethodPath) throws -> URL {
        var path = methodPath.path
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        
        let urlString = ApiConstants.baseUrl + path
        
        guard let methodURL = URL(string: urlString) else {
            throw URLError.cannotBeFormed
        }

        return methodURL
    }
}
