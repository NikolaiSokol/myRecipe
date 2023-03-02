//
//  DietType.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import Foundation

enum DietType: String, CaseIterable {
    case `default`
    case glutenFree
    case ketogenic
    case vegetarian
    case lactoVegetarian
    case ovoVegetarian
    case vegan
    case pescetarian
    case paleo
    case primal
    case lowFODMAP
    case whole30
}

extension DietType: Localizable {
    // swiftlint:disable:next cyclomatic_complexity
    func localizedString() -> String {
        switch self {
        case .default:
            return String(localized: .select)
            
        case .glutenFree:
            return String(localized: .dietGlutenFree)
            
        case .ketogenic:
            return String(localized: .dietKetogenic)
            
        case .vegetarian:
            return String(localized: .dietVegetarian)
            
        case .lactoVegetarian:
            return String(localized: .dietLactoVegetarian)
            
        case .ovoVegetarian:
            return String(localized: .dietOvoVegetarian)
            
        case .vegan:
            return String(localized: .dietVegan)
            
        case .pescetarian:
            return String(localized: .dietPescetarian)
            
        case .paleo:
            return String(localized: .dietPaleo)
            
        case .primal:
            return String(localized: .dietPrimal)
            
        case .lowFODMAP:
            return String(localized: .dietLowFODMAP)
            
        case .whole30:
            return String(localized: .dietWhole30)
        }
    }
}
