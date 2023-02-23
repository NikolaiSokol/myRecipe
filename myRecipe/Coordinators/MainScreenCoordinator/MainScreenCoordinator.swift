//
//  MainScreenCoordinator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

final class MainScreenCoordinator {
    private weak var output: MainScreenCoordinatorOutput?
    private let coordinatorsFactory: CoordinatorsFactoring
    private let rootModulesFactory: RootModulesFactoring
    private let modulesFactory: ModulesFactoring
    private let router: Router
    
    private var mainScreenRootInput: MainScreenRootInput?
    
    private var recipeScreenCoordinatorInput: RecipeScreenCoordinatorInput?
    
    init(
        output: MainScreenCoordinatorOutput,
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
    
    private func showMainScreenRoot() -> AnyView {
        let unit = rootModulesFactory.makeMainScreenRoot(output: self, router: router)
        mainScreenRootInput = unit.input
        mainScreenRootInput?.bootstrap()
        
        return unit.view
    }
    
    private func presentRecipeScreen(inputModel: RecipeScreenInputModel) {
        let unit = coordinatorsFactory.makeRecipeScreenCoordinator(output: self, router: router)
        recipeScreenCoordinatorInput = unit.input
        unit.coordinator.start(with: inputModel)
    }
}

// MARK: - RootCoordinator

extension MainScreenCoordinator: RootCoordinator {
    func start() -> AnyView {
        showMainScreenRoot()
    }
}

// MARK: - MainScreenRootInput

extension MainScreenCoordinator: MainScreenCoordinatorInput {
    func popToRoot() {
        router.popToRoot()
    }
}

// MARK: - MainScreenRootOutput

extension MainScreenCoordinator: MainScreenRootOutput {}

// MARK: - RecipeScreenCoordinatorOutput

extension MainScreenCoordinator: RecipeScreenCoordinatorOutput {
    func openRecipe(id: Int) {
        let inputModel = RecipeScreenInputModel(id: id)
        
        presentRecipeScreen(inputModel: inputModel)
    }
}
