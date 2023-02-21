//
//  RecipesVerticalListView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import SwiftUI

final class RecipesVerticalListViewModel: ObservableObject {
    @Published var cards: [HorizontalRecipeCardViewModel] = []
    @Published var contentState: ViewContentState = .skeleton
}

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
}

struct RecipesVerticalListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesVerticalListView(
            viewModel: RecipesVerticalListViewModel()
        )
    }
}
