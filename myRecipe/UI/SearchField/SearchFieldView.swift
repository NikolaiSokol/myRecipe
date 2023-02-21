//
//  SearchFieldView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 20.02.2023.
//

import SwiftUI

struct SearchFieldView: View {
    private enum LocalConstants {
        static let height: CGFloat = 50
    }
    
    @ObservedObject private var viewModel: SearchFieldViewModel
    @FocusState var shouldBeFocused: Bool
    
    init(viewModel: SearchFieldViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("accentGray"))
                .padding(.leading, UIConstants.Paddings.xxs)
            
            TextField("Search recipes", text: $viewModel.text)
                .focused($shouldBeFocused)
            
            if !viewModel.text.isEmpty {
                Button(action: viewModel.didTapClearButton) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("accentGray"))
                }
                .buttonStyle(.plain)
                .padding(.trailing, UIConstants.Paddings.xxs)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: LocalConstants.height)
        .background(Color("secondaryGray"))
        .cornerRadius(UIConstants.Radius.s)
        .onReceive(viewModel.endEditingSubject) {
            shouldBeFocused = false
        }
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchFieldView(viewModel: SearchFieldViewModel())
    }
}
