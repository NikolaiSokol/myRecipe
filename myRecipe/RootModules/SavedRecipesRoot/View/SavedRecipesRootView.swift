//
//  SavedRecipesRootView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//  
//

import SwiftUI

struct SavedRecipesRootView: View {
    @ObservedObject private var state: SavedRecipesRootViewState
    @ObservedObject private var router: Router
    private weak var output: SavedRecipesRootViewOutput?
    
    init(
        state: SavedRecipesRootViewState,
        router: Router,
        output: SavedRecipesRootViewOutput
    ) {
        self.state = state
        self.router = router
        self.output = output
    }
    
    var body: some View {
        NavigationStack(path: $router.navigableViews) {
            actualBody
                .navigationDestination(for: NavigableView.self) {
                    $0.view
                }
                .navigationTitle(String(localized: .savedRecipes))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder private var actualBody: some View {
        VStack(spacing: UIConstants.Paddings.xxs) {
            searchBox

            recipesList
        }
        .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    @ViewBuilder private var searchBox: some View {
        if let model = state.searchBoxModel {
            SearchBoxView(state: model.viewState, output: model.viewOutput)
        }
    }

    private var recipesList: some View {
        RecipesVerticalListView(viewModel: state.recipesViewModel)
            .onTapGesture {
                output?.endEditing()
            }
    }
}
