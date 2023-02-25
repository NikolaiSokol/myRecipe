//
//  SettingsScreenRootConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class SettingsScreenRootConfigurator {
    private let modulesFactory: ModulesFactoring
    
    init(modulesFactory: ModulesFactoring) {
        self.modulesFactory = modulesFactory
    }
    
    func configure(router: Router, output: SettingsScreenRootOutput) -> RootModule<SettingsScreenRootInput> {
        let viewState = SettingsScreenRootViewState()
        
        let presenter = SettingsScreenRootPresenter(
            viewState: viewState,
            output: output,
            modulesFactory: modulesFactory
        )
        
        let view = SettingsScreenRootView(state: viewState, router: router, output: presenter)
        
        return (view.eraseToAnyView(), presenter)
    }
}
