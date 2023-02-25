//
//  RecipeScreenPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

final class RecipeScreenPresenter {
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

extension RecipeScreenPresenter: RecipeScreenInput {
    func configure(inputModel: RecipeScreenInputModel) {
        viewState.recipe = inputModel.recipe
    }
}

// MARK: - RecipeScreenViewOutput

extension RecipeScreenPresenter: RecipeScreenViewOutput {}
