//
//  MeasureSystem.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 25.02.2023.
//

import Foundation

enum MeasureSystem: String, CaseIterable, Codable {
    case us
    case metric
}

extension MeasureSystem: Localizable {
    func localizedString() -> String {
        switch self {
        case .us:
            return String(localized: .us)
            
        case .metric:
            return String(localized: .metric)
        }
    }
}

extension MeasureSystem: Identifiable {
    var id: Self {
        self
    }
}
