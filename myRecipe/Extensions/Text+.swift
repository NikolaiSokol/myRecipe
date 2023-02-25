//
//  Text+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 25.02.2023.
//

import SwiftUI

extension Text {
    func customFont(size: CGFloat) -> some View {
        font(.custom("Poppins", size: size))
    }
}
