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
    func makeSettingsScreen(output: SettingsScreenOutput) -> SettingsScreenModule {
        SettingsScreenConfigurator().configure(output: output)
    }
    
    func makeRecipeScreen(output: RecipeScreenOutput) -> NavigableModule<RecipeScreenInput> {
        RecipeScreenConfigurator(dependencies: dependencies).configure(output: output)
    }
    
    func makeSearchBox(output: SearchBoxOutput) -> SearchBoxModule {
        SearchBoxConfigurator().configure(output: output)
    }
    
    func makeRandomRecipesByType(output: RandomRecipesByTypeOutput) -> RandomRecipesByTypeModule {
        RandomRecipesByTypeConfigurator(dependencies: dependencies).configure(output: output)
    }
}
