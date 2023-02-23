//
//  SizePreferenceKey.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//

import SwiftUI

public struct SizePreferenceKey: PreferenceKey {
    public static var defaultValue: CGSize = .zero

    public static func reduce(value _: inout CGSize, nextValue: () -> CGSize) {
        _ = nextValue()
    }
}
