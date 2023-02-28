//
//  SearchBoxView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import SwiftUI

struct SearchBoxView: View {
    private enum LocalConstants {
        static let height: CGFloat = 50
    }
    
    @ObservedObject private var state: SearchBoxViewState
    private weak var output: SearchBoxViewOutput?
    
    @FocusState var isFocused: Bool
    
    init(
        state: SearchBoxViewState,
        output: SearchBoxViewOutput
    ) {
        self.state = state
        self.output = output
    }
    
    var body: some View {
        HStack {
            image
            
            textField
            
            clearButton
        }
        .frame(maxWidth: .infinity)
        .frame(height: LocalConstants.height)
        .background(Color(.secondaryGray))
        .cornerRadius(UIConstants.Radius.s)
        .onReceive(state.shouldBeFocusedSubject) {
            isFocused = $0
        }
        .onChange(of: isFocused) {
            if $0 {
                state.didBecomeFocusedSubject.send()
            }
        }
    }
    
    private var image: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(Color(.accentGray))
            .padding(.leading, UIConstants.Paddings.xxs)
    }
    
    private var textField: some View {
        TextField(String(localized: .searchRecipes), text: $state.text)
            .focused($isFocused)
            .submitLabel(.search)
            .onSubmit {
                output?.didTapReturnKey()
            }
    }
    
    @ViewBuilder private var clearButton: some View {
        if !state.text.isEmpty {
            Button(action: state.didTapClearButton) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color(.accentGray))
            }
            .buttonStyle(.plain)
            .padding(.trailing, UIConstants.Paddings.xxs)
        }
    }
}
