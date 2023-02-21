//
//  MainScreenConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

typealias MainScreenModule = (model: MainScreenModel, input: MainScreenInput)

struct MainScreenModel {
    let viewState: MainScreenViewState
    let viewOutput: MainScreenViewOutput
}

final class MainScreenConfigurator {
    private let dependencies: DependenciesProtocol
    
    init(dependencies: DependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func configure(output: MainScreenOutput) -> MainScreenModule {
        let viewState = MainScreenViewState()
        
        let viewModel = MainScreenViewModel(
            viewState: viewState,
            output: output,
            searchService: dependencies.searchService
        )
        
        let model = MainScreenModel(viewState: viewState, viewOutput: viewModel)
        
        return (model, viewModel)
    }
}
