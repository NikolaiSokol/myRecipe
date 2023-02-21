//
//  MyRecipeApp.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

@main
struct MyRecipeApp: App {
    private let tabBarCoordinator: RootCoordinator
    
    init() {
        let dependencies = Dependencies()
        let modulesFactory = ModulesFactory(dependencies: dependencies)
        let rootModulesFactory = RootModulesFactory(modulesFactory: modulesFactory)
        let coordinatorsFactory = CoordinatorsFactory(
            rootModulesFactory: rootModulesFactory,
            modulesFactory: modulesFactory
        )
        
        tabBarCoordinator = coordinatorsFactory.makeTabBarCoordinator()
    }
    
    var body: some Scene {
        WindowGroup {
            tabBarCoordinator.start()
        }
    }
}
