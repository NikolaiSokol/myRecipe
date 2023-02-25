//
//  RandomRecipesByTypeConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation

typealias RandomRecipesByTypeModule = (model: RandomRecipesByTypeModel, input: RandomRecipesByTypeInput)

struct RandomRecipesByTypeModel {
    let viewState: RandomRecipesByTypeViewState
    let viewOutput: RandomRecipesByTypeViewOutput
}

final class RandomRecipesByTypeConfigurator {
    private let dependencies: DependenciesProtocol
    
    init(dependencies: DependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func configure(output: RandomRecipesByTypeOutput) -> RandomRecipesByTypeModule {
        let viewState = RandomRecipesByTypeViewState()
        
        let presenter = RandomRecipesByTypePresenter(
            viewState: viewState,
            output: output,
            randomRecipesService: dependencies.randomRecipesService
        )
        
        let model = RandomRecipesByTypeModel(viewState: viewState, viewOutput: presenter)
        
        return (model, presenter)
    }
}
