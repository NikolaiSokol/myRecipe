//
//  View+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    /// Applies a modifier to a view conditionally.
    ///
    /// - Parameters:
    ///   - condition: The condition to determine if the content should be applied.
    ///   - content: The modifier to apply to the view.
    /// - Returns: The modified view.
    @ViewBuilder func modifier<T: View>(
        if condition: @autoclosure () -> Bool,
        then content: (Self) -> T
    ) -> some View {
        if condition() {
            content(self)
        } else {
            self
        }
    }
    
    func getViewSize(_ size: Binding<CGSize>, spaceName: String) -> some View {
        modifier(GenericPreferenceSizeReaderModifier(
            coordinateSpaceName: spaceName,
            size: size,
            preferenceKey: SizePreferenceKey.self
        ))
    }
    
    func onFrameChanged(
        in coordinateSpace: String,
        perform: @escaping (CGRect) -> Void
    ) -> some View {
        modifier(
            GenericPreferenceFrameReaderModifier(
                coordinateSpace: coordinateSpace,
                frame: .constant(.zero),
                preferenceKey: FramePreferenceKey.self,
                actionBlock: perform
            )
        )
    }
}
