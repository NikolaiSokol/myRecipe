//
//  IntoleranceType.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import Foundation

enum IntoleranceType: String, CaseIterable, Codable {
    case dairy
    case egg
    case gluten
    case grain
    case peanut
    case seafood
    case sesame
    case shellfish
    case soy
    case sulfite
    case treeNut
    case wheat
}

extension IntoleranceType: Localizable {
    // swiftlint:disable:next cyclomatic_complexity
    func localizedString() -> String {
        switch self {
        case .dairy:
            return String(localized: .intoleranceDairy)
            
        case .egg:
            return String(localized: .intoleranceEgg)
            
        case .gluten:
            return String(localized: .intoleranceGluten)
            
        case .grain:
            return String(localized: .intoleranceGrain)
            
        case .peanut:
            return String(localized: .intolerancePeanut)
            
        case .seafood:
            return String(localized: .intoleranceSeafood)
            
        case .sesame:
            return String(localized: .intoleranceSesame)
            
        case .shellfish:
            return String(localized: .intoleranceShellfish)
            
        case .soy:
            return String(localized: .intoleranceSoy)
            
        case .sulfite:
            return String(localized: .intoleranceSulfite)
            
        case .treeNut:
            return String(localized: .intoleranceTreeNut)
            
        case .wheat:
            return String(localized: .intoleranceWheat)
        }
    }
}

extension IntoleranceType: Comparable {
    static func < (lhs: IntoleranceType, rhs: IntoleranceType) -> Bool {
        lhs.localizedString() < rhs.localizedString()
    }
}

extension IntoleranceType: Identifiable {
    var id: Self {
        self
    }
}
