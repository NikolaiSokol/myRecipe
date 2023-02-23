//
//  MainScreenRootConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenRootConfigurator {
    private let dependencies: DependenciesProtocol
    private let modulesFactory: ModulesFactoring
    
    init(
        dependencies: DependenciesProtocol,
        modulesFactory: ModulesFactoring
    ) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory
    }
    
    func configure(router: Router, output: MainScreenRootOutput) -> RootModule<MainScreenRootInput> {
        let viewState = MainScreenRootViewState()
        
        let viewModel = MainScreenRootViewModel(
            viewState: viewState,
            output: output,
            modulesFactory: modulesFactory,
            randomRecipesService: dependencies.randomRecipesService
        )
        
        let view = MainScreenRootView(state: viewState, router: router, output: viewModel)
        
        return (view.eraseToAnyView(), viewModel)
    }
}
