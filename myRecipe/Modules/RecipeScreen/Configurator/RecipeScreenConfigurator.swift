//
//  RecipeScreenConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

final class RecipeScreenConfigurator {
    func configure(output: RecipeScreenOutput) -> NavigableModule<RecipeScreenInput> {
        let viewState = RecipeScreenViewState()
        
        let viewModel = RecipeScreenViewModel(
            viewState: viewState,
            output: output
        )
        
        let view = RecipeScreenView(state: viewState, output: viewModel)
        
        return (NavigableView(view: view.eraseToAnyView()), viewModel)
    }
}
