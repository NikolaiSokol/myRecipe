//
//  RecipesVerticalListView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import SwiftUI

struct RecipesVerticalListView: View {
    @ObservedObject private var viewModel: RecipesVerticalListViewModel
    
    init(viewModel: RecipesVerticalListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.contentState {
        case .skeleton:
            skeleton
            
        case .content:
            content
            
        case .error:
            errorScreen
        }
    }
    
    private var skeleton: some View {
        VStack {
            ForEach(0 ..< 3) { _ in
                HorizontalRecipeCardSkeletonView()
            }
        }
    }
    
    private var content: some View {
        LazyVStack {
            ForEach(viewModel.cards) {
                HorizontalRecipeCardView(viewModel: $0)
            }
        }
    }
    
    @ViewBuilder private var errorScreen: some View {
        if let model = viewModel.errorViewModel {
            ErrorView(viewModel: model)
                .padding(.top, UIConstants.Paddings.xl)
        }
    }
}

struct RecipesVerticalListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesVerticalListView(
            viewModel: RecipesVerticalListViewModel()
        )
    }
}
