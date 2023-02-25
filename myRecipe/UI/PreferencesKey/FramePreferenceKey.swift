//
//  FramePreferenceKey.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import SwiftUI

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value _: inout CGRect, nextValue: () -> CGRect) {
        _ = nextValue()
    }
}
