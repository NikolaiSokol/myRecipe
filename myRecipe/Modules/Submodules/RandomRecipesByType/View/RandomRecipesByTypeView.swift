//
//  RandomRecipesByTypeView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import SwiftUI

struct RandomRecipesByTypeView: View {
    @ObservedObject private var state: RandomRecipesByTypeViewState
    private let output: RandomRecipesByTypeViewOutput
    
    init(
        state: RandomRecipesByTypeViewState,
        output: RandomRecipesByTypeViewOutput
    ) {
        self.state = state
        self.output = output
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            carousel

            recipes
        }
    }
    
    private var carousel: some View {
        SingleSelectionCarouselView(
            viewModel: state.carouselViewModel,
            horizontalInsets: UIConstants.Paddings.s
        )
    }
    
    private var recipes: some View {
        RecipesVerticalListView(viewModel: state.recipesViewModel)
            .padding(.horizontal, UIConstants.Paddings.s)
            .padding(.top, UIConstants.Paddings.xs)
    }
}
