//
//  MethodPath.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

enum MethodPath {
    case search
    
    var path: String {
        switch self {
        case .search:
            return "recipes/complexSearch"
        }
    }
}
