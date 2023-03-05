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
    private let persistentService: PersistentServicing
    
    private var searchBoxInput: SearchBoxInput?
    
    private var recipes: [Recipe] = []

    init(
        viewState: SavedRecipesRootViewState,
        output: SavedRecipesRootOutput,
        modulesFactory: ModulesFactoring,
        persistentService: PersistentServicing
    ) {
        self.viewState = viewState
        self.output = output
        self.modulesFactory = modulesFactory
        self.persistentService = persistentService
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
    
    private func handleRecipeCardTapped(id: Int) {
        guard let recipe = recipes.first(where: { $0.id == id }) else {
            return
        }
        
        output?.savedRecipesRootDidRequest(event: .openRecipe(recipe))
    }
    
    private func fetchRecipes() {
        do {
            let recipes = try persistentService.getRecipes()
            
            updateRecipes(recipes)
            
        } catch {
            ErrorLogger.shared.log(error)
        }
    }
    
    private func updateRecipes(_ recipes: [Recipe]) {
        guard self.recipes != recipes else {
            return
        }
        
        self.recipes = recipes
        
        viewState.recipesViewModel.cards = recipes.map {
            HorizontalRecipeCardViewModel(
                id: $0.id,
                imageUrl: $0.imageUrl,
                name: $0.title,
                timeToCook: $0.readyInMinutes,
                recipeCardTapHandler: handleRecipeCardTapped
            )
        }
    }
}

// MARK: - SavedRecipesRootInput

extension SavedRecipesRootPresenter: SavedRecipesRootInput {
    func bootstrap() {
        fetchRecipes()
        setupSearchBox()
        setupRecipesList()
    }
    
    func updateRecipes() {
        fetchRecipes()
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
            print(text)
            
        case .returnKeyTapped:
            break
            
        case .textFieldBecameFocused:
            break
        }
    }
}
