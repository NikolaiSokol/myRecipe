//
//  MethodPath.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

enum MethodPath {
    case search
    case autocomplete
    case random
    case recipeInformation(Int)
    
    var path: String {
        switch self {
        case .search:
            return "recipes/complexSearch"
            
        case .autocomplete:
            return "recipes/autocomplete"
            
        case .random:
            return "recipes/random"
            
        case let .recipeInformation(id):
            return "recipes/\(id)/information"
        }
    }
}
