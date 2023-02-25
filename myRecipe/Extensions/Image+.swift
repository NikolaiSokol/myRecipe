//
//  Image+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 25.02.2023.
//

import SwiftUI

extension Image {
    init(_ imageName: ImageName) {
        self.init(imageName.rawValue)
    }
}
