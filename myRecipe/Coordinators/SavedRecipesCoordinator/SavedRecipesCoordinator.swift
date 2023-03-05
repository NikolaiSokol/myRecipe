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
}

// MARK: - SavedRecipesRootOutput

extension SavedRecipesCoordinator: SavedRecipesRootOutput {}
