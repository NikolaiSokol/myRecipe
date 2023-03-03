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
    // MARK: - Navigable
    
    func makeRecipeScreen(output: RecipeScreenOutput) -> NavigableModule<RecipeScreenInput> {
        RecipeScreenConfigurator(dependencies: dependencies).configure(output: output)
    }
    
    func makeSearchScreen(output: SearchScreenOutput) -> NavigableModule<SearchScreenInput> {
        SearchScreenConfigurator(dependencies: dependencies, modulesFactory: self)
            .configure(output: output)
    }
    
    // MARK: - Submodules
    
    func makeSearchBox(output: SearchBoxOutput) -> SearchBoxModule {
        SearchBoxConfigurator().configure(output: output)
    }
    
    func makeRandomRecipesByType(output: RandomRecipesByTypeOutput) -> RandomRecipesByTypeModule {
        RandomRecipesByTypeConfigurator(dependencies: dependencies).configure(output: output)
    }
}
