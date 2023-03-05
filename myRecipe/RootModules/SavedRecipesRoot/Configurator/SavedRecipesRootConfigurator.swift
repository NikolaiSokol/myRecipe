//
//  SavedRecipesRootConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//  
//

import Foundation

final class SavedRecipesRootConfigurator {
    private let dependencies: DependenciesProtocol
    private let modulesFactory: ModulesFactoring
    
    init(
        dependencies: DependenciesProtocol,
        modulesFactory: ModulesFactoring
    ) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory
    }
    
    func configure(router: Router, output: SavedRecipesRootOutput) -> RootModule<SavedRecipesRootInput> {
        let viewState = SavedRecipesRootViewState()
        
        let presenter = SavedRecipesRootPresenter(
            viewState: viewState,
            output: output,
            modulesFactory: modulesFactory
        )
        
        let view = SavedRecipesRootView(state: viewState, router: router, output: presenter)
        
        return (view.eraseToAnyView(), presenter)
    }
}
