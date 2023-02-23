//
//  RecipeScreenViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

final class RecipeScreenViewModel {
    private let viewState: RecipeScreenViewState
    private weak var output: RecipeScreenOutput?

    init(
        viewState: RecipeScreenViewState,
        output: RecipeScreenOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
}

// MARK: - RecipeScreenInput

extension RecipeScreenViewModel: RecipeScreenInput {
    func configure(inputModel: RecipeScreenInputModel) {
        viewState.recipeId = inputModel.id
    }
}

// MARK: - RecipeScreenViewOutput

extension RecipeScreenViewModel: RecipeScreenViewOutput {}
