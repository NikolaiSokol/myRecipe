//
//  Color+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 25.02.2023.
//

import SwiftUI

extension Color {
    init(_ colorName: ColorName) {
        self.init(colorName.rawValue)
    }
}
