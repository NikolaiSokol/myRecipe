//
//  GenericPreferenceFrameReaderModifier.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import SwiftUI

struct GenericPreferenceFrameReaderModifier<P: PreferenceKey>: ViewModifier where P.Value == CGRect {
    fileprivate let coordinateSpace: String
    @Binding var frame: CGRect
    let prefKeyType: P.Type
    let actionBlock: ((CGRect) -> Void)?

    init(
        coordinateSpace: String,
        frame: Binding<CGRect>,
        preferenceKey: P.Type,
        actionBlock: ((CGRect) -> Void)?
    ) {
        self.coordinateSpace = coordinateSpace
        _frame = frame
        prefKeyType = preferenceKey
        self.actionBlock = actionBlock
    }

    public func body(content: Content) -> some View {
        content
            .background(frameReader)
            .onPreferenceChange(prefKeyType, perform: onChangeFrame)
    }

    private var frameReader: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: prefKeyType, value: proxy.frame(in: .named(coordinateSpace)))
        }
    }

    private func onChangeFrame(_ frame: CGRect) {
        if let block = actionBlock {
            block(frame)
        } else if self.frame != frame {
            self.frame = frame
        }
    }
}
