//
//  SortingOption.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import Foundation

enum SortingOption: String, CaseIterable {
    case `default`
    case popularity
    case time
    case calories
    
    func isDefault() -> Bool {
        self == .default
    }
    
    func localizedString() -> String {
        switch self {
        case .default:
            return String(localized: .defaultSorting)
            
        case .popularity:
            return String(localized: .popularity)
            
        case .time:
            return String(localized: .cookTime)
            
        case .calories:
            return String(localized: .calories)
        }
    }
}

extension SortingOption: Identifiable {
    var id: Self {
        self
    }
}
