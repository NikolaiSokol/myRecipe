//
//  GenericPreferenceSizeReaderModifier.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//

import Foundation
import SwiftUI

struct GenericPreferenceSizeReaderModifier<P: PreferenceKey>: ViewModifier where P.Value == CGSize {
    fileprivate let coordinateSpaceName: String
    @Binding var size: CGSize
    let prefKeyType: P.Type

    init(
        coordinateSpaceName: String,
        size: Binding<CGSize>,
        preferenceKey: P.Type
    ) {
        self.coordinateSpaceName = coordinateSpaceName
        _size = size
        prefKeyType = preferenceKey
    }

    func body(content: Content) -> some View {
        content
            .background(sizeReader)
            .onPreferenceChange(prefKeyType, perform: onChangeSize)
            .coordinateSpace(name: coordinateSpaceName)
    }

    private var sizeReader: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: prefKeyType, value: proxy.size)
        }
    }

    private func onChangeSize(_ size: CGSize) {
        if self.size != size {
            self.size = size
        }
    }
}
