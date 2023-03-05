//
//  SavedRecipesRootPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//  
//

import Foundation

final class SavedRecipesRootPresenter {
    private let viewState: SavedRecipesRootViewState
    private weak var output: SavedRecipesRootOutput?

    init(
        viewState: SavedRecipesRootViewState,
        output: SavedRecipesRootOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
}

// MARK: - SavedRecipesRootInput

extension SavedRecipesRootPresenter: SavedRecipesRootInput {
    func bootstrap() {
        
    }
}

// MARK: - SavedRecipesRootViewOutput

extension SavedRecipesRootPresenter: SavedRecipesRootViewOutput {}
