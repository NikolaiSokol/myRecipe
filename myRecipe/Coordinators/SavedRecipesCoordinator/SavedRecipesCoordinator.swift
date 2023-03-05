//
//  SavedRecipesCoordinator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//

import Foundation
import SwiftUI

final class SavedRecipesCoordinator {
    private weak var output: SavedRecipesCoordinatorOutput?
    private let coordinatorsFactory: CoordinatorsFactoring
    private let rootModulesFactory: RootModulesFactoring
    private let modulesFactory: ModulesFactoring
    private let router: Router
    
    private var savedRecipesRootInput: SavedRecipesRootInput?
    
    private var recipeScreenCoordinatorInput: RecipeScreenCoordinatorInput?
    
    init(
        output: SavedRecipesCoordinatorOutput,
        coordinatorsFactory: CoordinatorsFactoring,
        rootModulesFactory: RootModulesFactoring,
        modulesFactory: ModulesFactoring
    ) {
        self.output = output
        self.coordinatorsFactory = coordinatorsFactory
        self.rootModulesFactory = rootModulesFactory
        self.modulesFactory = modulesFactory
        
        router = Router()
    }
    
    private func showSavedRecipesScreenRoot() -> AnyView {
        let unit = rootModulesFactory.makeSavedRecipesScreenRoot(output: self, router: router)
        
        savedRecipesRootInput = unit.input
        savedRecipesRootInput?.bootstrap()
        
        return unit.view
    }
    
    private func presentRecipeScreen(inputModel: RecipeScreenInputModel) {
        let unit = coordinatorsFactory.makeRecipeScreenCoordinator(output: self, router: router)
        
        recipeScreenCoordinatorInput = unit.input
        
        unit.coordinator.start(with: inputModel)
    }
}

// MARK: - RootCoordinator

extension SavedRecipesCoordinator: RootCoordinator {
    func start() -> AnyView {
        showSavedRecipesScreenRoot()
    }
}

// MARK: - MainScreenRootInput

extension SavedRecipesCoordinator: SavedRecipesCoordinatorInput {
    func popToRoot() {
        router.popToRoot()
    }
    
    func updateRecipes() {
        savedRecipesRootInput?.updateRecipes()
    }
}

// MARK: - SavedRecipesRootOutput

extension SavedRecipesCoordinator: SavedRecipesRootOutput {
    func savedRecipesRootDidRequest(event: SavedRecipesRootEvent) {
        switch event {
        case let .openRecipe(recipe):
            presentRecipeScreen(
                inputModel: RecipeScreenInputModel(recipe: recipe)
            )
        }
    }
}

// MARK: - RecipeScreenCoordinatorOutput

extension SavedRecipesCoordinator: RecipeScreenCoordinatorOutput {
    func recipeScreenCoordinatorDidRequest(event: RecipeScreenCoordinatorEvent) {
        switch event {
        case .persistentChanged:
            savedRecipesRootInput?.updateRecipes()
        }
    }
}
