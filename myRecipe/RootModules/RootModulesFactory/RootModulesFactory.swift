//
//  RootModulesFactory.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class RootModulesFactory {
    private let dependencies: DependenciesProtocol
    private let modulesFactory: ModulesFactoring
    
    init(
        dependencies: DependenciesProtocol,
        modulesFactory: ModulesFactoring
    ) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory
    }
}

extension RootModulesFactory: RootModulesFactoring {
    func makeTabBar(output: TabBarOutput) -> RootModule<TabBarInput> {
        TabBarConfigurator().configure(output: output)
    }
    
    func makeMainScreenRoot(
        output: MainScreenRootOutput,
        router: Router
    ) -> RootModule<MainScreenRootInput> {
        MainScreenRootConfigurator(dependencies: dependencies, modulesFactory: modulesFactory)
            .configure(router: router, output: output)
    }
    
    func makeSettingsScreenRoot(
        output: SettingsScreenRootOutput,
        router: Router
    ) -> RootModule<SettingsScreenRootInput> {
        SettingsScreenRootConfigurator(modulesFactory: modulesFactory)
            .configure(router: router, output: output)
    }
}
