//
//  SettingsScreenRootConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class SettingsScreenRootConfigurator {
    private let dependencies: DependenciesProtocol
    
    init(dependencies: DependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func configure(router: Router, output: SettingsScreenRootOutput) -> RootModule<SettingsScreenRootInput> {
        let viewState = SettingsScreenRootViewState()
        
        let presenter = SettingsScreenRootPresenter(
            viewState: viewState,
            output: output,
            userDefaultsService: dependencies.userDefaultsService
        )
        
        let view = SettingsScreenRootView(state: viewState, router: router, output: presenter)
        
        return (view.eraseToAnyView(), presenter)
    }
}
