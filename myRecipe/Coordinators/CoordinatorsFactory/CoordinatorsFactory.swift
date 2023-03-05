//
//  CoordinatorsFactory.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class CoordinatorsFactory {
    let rootModulesFactory: RootModulesFactoring
    let modulesFactory: ModulesFactoring
    
    init(
        rootModulesFactory: RootModulesFactoring,
        modulesFactory: ModulesFactoring
    ) {
        self.rootModulesFactory = rootModulesFactory
        self.modulesFactory = modulesFactory
    }
}

extension CoordinatorsFactory: CoordinatorsFactoring {
    func makeTabBarCoordinator() -> RootCoordinator {
        TabBarCoordinator(
            coordinatorFactory: self,
            rootModulesFactory: rootModulesFactory,
            modulesFactory: modulesFactory
        )
    }
    
    func makeMainScreenRootCoordinator(
        output: MainScreenCoordinatorOutput
    ) -> RootCoordinatorModule<MainScreenCoordinatorInput> {
        let coordinator = MainScreenCoordinator(
            output: output,
            coordinatorsFactory: self,
            rootModulesFactory: rootModulesFactory,
            modulesFactory: modulesFactory
        )
        
        return (coordinator.start(), coordinator)
    }
    
    func makeSavedRecipesRootCoordinator(
        output: SavedRecipesCoordinatorOutput
    ) -> RootCoordinatorModule<SavedRecipesCoordinatorInput> {
        let coordinator = SavedRecipesCoordinator(
            output: output,
            coordinatorsFactory: self,
            rootModulesFactory: rootModulesFactory,
            modulesFactory: modulesFactory
        )
        
        return (coordinator.start(), coordinator)
    }
    
    func makeSettingsScreenRootCoordinator(
        output: SettingsScreenCoordinatorOutput
    ) -> RootCoordinatorModule<SettingsScreenCoordinatorInput> {
        let coordinator = SettingsScreenCoordinator(
            output: output,
            coordinatorsFactory: self,
            rootModulesFactory: rootModulesFactory,
            modulesFactory: modulesFactory
        )
        
        return (coordinator.start(), coordinator)
    }
    
    func makeRecipeScreenCoordinator(
        output: RecipeScreenCoordinatorOutput,
        router: Routable
    ) -> ConcreteCoordinator<RecipeScreenCoordinatorInput> {
        let coordinator = RecipeScreenCoordinator(
            output: output,
            modulesFactory: modulesFactory,
            router: router
        )
        
        return (coordinator, coordinator)
    }
    
    func makeSearchScreenCoordinator(
        output: SearchScreenCoordinatorOutput,
        router: Routable
    ) -> ConcreteCoordinator<SearchScreenCoordinatorInput> {
        let coordinator = SearchScreenCoordinator(
            output: output,
            coordinatorsFactory: self,
            modulesFactory: modulesFactory,
            router: router
        )
        
        return (coordinator, coordinator)
    }
}
