//
//  String+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

extension String {
    init(localized: Localized) {
        self.init(localized: String.LocalizationValue(localized.rawValue))
    }
    
    func capitalizingFirstLetter() -> Self {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func removeHtmlTags() -> Self {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
