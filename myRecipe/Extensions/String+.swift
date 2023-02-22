//
//  String+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> Self {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func localized() -> Self {
        Self(localized: Self.LocalizationValue(self))
    }
}
