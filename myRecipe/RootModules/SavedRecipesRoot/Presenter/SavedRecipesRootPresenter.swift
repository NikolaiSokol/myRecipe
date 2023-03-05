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
    private let modulesFactory: ModulesFactoring
    
    private var searchBoxInput: SearchBoxInput?

    init(
        viewState: SavedRecipesRootViewState,
        output: SavedRecipesRootOutput,
        modulesFactory: ModulesFactoring
    ) {
        self.viewState = viewState
        self.output = output
        self.modulesFactory = modulesFactory
    }
    
    private func setupSearchBox() {
        let unit = modulesFactory.makeSearchBox(output: self)
        
        searchBoxInput = unit.input
        searchBoxInput?.configure(shouldBeFocused: false)
        
        viewState.searchBoxModel = unit.model
    }
    
    private func setupRecipesList() {
        viewState.recipesViewModel.isRefreshable = false
        viewState.recipesViewModel.updateContentState(to: .content)
    }
}

// MARK: - SavedRecipesRootInput

extension SavedRecipesRootPresenter: SavedRecipesRootInput {
    func bootstrap() {
        setupSearchBox()
        setupRecipesList()
    }
}

// MARK: - SavedRecipesRootViewOutput

extension SavedRecipesRootPresenter: SavedRecipesRootViewOutput {
    func endEditing() {
        searchBoxInput?.endEditing()
    }
}

// MARK: - SearchBoxOutput

extension SavedRecipesRootPresenter: SearchBoxOutput {
    func searchBoxDidRequest(event: SearchBoxEvent) {
        switch event {
        case let .textChanged(text):
            break
            
        case .returnKeyTapped:
            break
            
        case .textFieldBecameFocused:
            break
        }
    }
}
