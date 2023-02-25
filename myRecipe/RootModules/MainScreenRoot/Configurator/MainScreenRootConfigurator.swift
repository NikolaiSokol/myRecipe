//
//  MainScreenRootConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenRootConfigurator {
    private let modulesFactory: ModulesFactoring
    
    init(modulesFactory: ModulesFactoring) {
        self.modulesFactory = modulesFactory
    }
    
    func configure(router: Router, output: MainScreenRootOutput) -> RootModule<MainScreenRootInput> {
        let viewState = MainScreenRootViewState()
        
        let presenter = MainScreenRootPresenter(
            viewState: viewState,
            output: output,
            modulesFactory: modulesFactory
        )
        
        let view = MainScreenRootView(state: viewState, router: router, output: presenter)
        
        return (view.eraseToAnyView(), presenter)
    }
}
