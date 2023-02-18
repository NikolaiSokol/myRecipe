//
//  RootModulesFactory.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class RootModulesFactory {
    private let modulesFactory: ModulesFactoring
    
    init(modulesFactory: ModulesFactoring) {
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
        MainScreenRootConfigurator(modulesFactory: modulesFactory)
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
