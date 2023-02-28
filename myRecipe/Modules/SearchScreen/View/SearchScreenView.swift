//
//  SearchScreenView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import SwiftUI

struct SearchScreenView: View {
    private enum LocalConstants {
        static let searchBoxNameSpace = "SearchScreenViewSearchBoxNameSpace"
    }
    
    @ObservedObject private var state: SearchScreenViewState
    private weak var output: SearchScreenViewOutput?
    
    @State private var searchBoxSize: CGSize = .zero
    
    init(
        state: SearchScreenViewState,
        output: SearchScreenViewOutput
    ) {
        self.state = state
        self.output = output
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            searchBox
            
            recipesList
            
            searchSuggestions
        }
        .navigationBarHidden(true)
        .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    @ViewBuilder private var searchBox: some View {
        if let output, let model = state.searchBoxModel {
            HStack {
                SearchBoxView(state: model.viewState, output: model.viewOutput)
                
                Button(action: output.didTapCancel) {
                    Text(String(localized: .cancel))
                        .customFont(size: UIConstants.Font.s)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.primaryAccent))
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom, UIConstants.Paddings.s)
            .getViewSize($searchBoxSize, spaceName: LocalConstants.searchBoxNameSpace)
        }
    }
    
    @ViewBuilder private var recipesList: some View {
        if !state.isShowingSearchSuggestions {
            RecipesVerticalListView(viewModel: state.recipesViewModel)
                .padding(.top, searchBoxSize.height)
                .onTapGesture {
                    output?.endEditing()
                }
        }
    }
    
    @ViewBuilder private var searchSuggestions: some View {
        if state.isShowingSearchSuggestions {
            SearchSuggestionsView(viewModel: state.suggestionsViewModel)
                .padding(.top, searchBoxSize.height)
                .onTapGesture {
                    output?.endEditing()
                }
        }
    }
}
