//
//  ModulesFactory.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class ModulesFactory {
    private let dependencies: DependenciesProtocol
    
    init(dependencies: DependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension ModulesFactory: ModulesFactoring {
    func makeMainScreen(output: MainScreenOutput) -> MainScreenModule {
        MainScreenConfigurator(dependencies: dependencies).configure(output: output)
    }
    
    func makeSettingsScreen(output: SettingsScreenOutput) -> SettingsScreenModule {
        SettingsScreenConfigurator().configure(output: output)
    }
}
