//
//  SearchScreenCoordinator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

final class SearchScreenCoordinator {
    private weak var output: SearchScreenCoordinatorOutput?
    private let coordinatorsFactory: CoordinatorsFactoring
    private let modulesFactory: ModulesFactoring
    private let router: Routable
    
    private var searchScreenInput: SearchScreenInput?
    private var recipeScreenCoordinatorInput: RecipeScreenCoordinatorInput?
    
    init(
        output: SearchScreenCoordinatorOutput?,
        coordinatorsFactory: CoordinatorsFactoring,
        modulesFactory: ModulesFactoring,
        router: Routable
    ) {
        self.output = output
        self.coordinatorsFactory = coordinatorsFactory
        self.modulesFactory = modulesFactory
        self.router = router
    }
    
    private func showSearchScreen() {
        let unit = modulesFactory.makeSearchScreen(output: self)
        
        searchScreenInput = unit.input
        searchScreenInput?.bootstrap()
        
        router.present(unit.view)
    }
    
    private func presentRecipeScreen(inputModel: RecipeScreenInputModel) {
        let unit = coordinatorsFactory.makeRecipeScreenCoordinator(output: self, router: router)
        
        recipeScreenCoordinatorInput = unit.input
        
        unit.coordinator.start(with: inputModel)
    }
}

extension SearchScreenCoordinator: Coordinator {
    func start(with option: CoordinatorOption?) {
        showSearchScreen()
    }
}

// MARK: - SearchScreenCoordinatorInput

extension SearchScreenCoordinator: SearchScreenCoordinatorInput {}

// MARK: - RecipeScreenCoordinatorOutput

extension SearchScreenCoordinator: RecipeScreenCoordinatorOutput {
    func recipeScreenCoordinatorDidRequest(event: RecipeScreenCoordinatorEvent) {
        switch event {
        case .persistentChanged:
            output?.searchScreenCoordinatorDidRequest(event: .persistentChanged)
        }
    }
}

// MARK: - SearchScreenOutput

extension SearchScreenCoordinator: SearchScreenOutput {
    func searchScreenDidRequest(event: SearchScreenEvent) {
        switch event {
        case .tappedCancelButton:
            router.pop()
            
        case let .openRecipe(recipe):
            presentRecipeScreen(
                inputModel: RecipeScreenInputModel(recipe: recipe)
            )
        }
    }
}
