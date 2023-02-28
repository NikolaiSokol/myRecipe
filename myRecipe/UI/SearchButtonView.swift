//
//  SearchButtonView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import SwiftUI

struct SearchButtonView: View {
    private enum LocalConstants {
        static let height: CGFloat = 50
    }
    
    private let tapHandler: () -> Void
    
    @State private var text = ""
    
    init(tapHandler: @escaping () -> Void) {
        self.tapHandler = tapHandler
    }
    
    var body: some View {
        Button(action: didTap) {
            HStack {
                image
                
                textField
            }
            .frame(maxWidth: .infinity)
            .frame(height: LocalConstants.height)
            .background(Color(.secondaryGray))
            .cornerRadius(UIConstants.Radius.s)
        }
    }
    
    private var image: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(Color(.accentGray))
            .padding(.leading, UIConstants.Paddings.xxs)
    }
    
    private var textField: some View {
        TextField(String(localized: .searchRecipes), text: $text)
            .multilineTextAlignment(.leading)
            .disabled(true)
    }
    
    private func didTap() {
        tapHandler()
    }
}

struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView {}
    }
}
