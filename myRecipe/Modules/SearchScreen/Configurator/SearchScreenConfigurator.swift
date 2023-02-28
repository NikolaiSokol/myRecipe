//
//  SearchScreenConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import Foundation

final class SearchScreenConfigurator {
    private let dependencies: DependenciesProtocol
    private let modulesFactory: ModulesFactoring
    
    init(
        dependencies: DependenciesProtocol,
        modulesFactory: ModulesFactoring
    ) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory
    }
    
    func configure(output: SearchScreenOutput) -> NavigableModule<SearchScreenInput> {
        let viewState = SearchScreenViewState()
        
        let presenter = SearchScreenPresenter(
            viewState: viewState,
            output: output,
            modulesFactory: modulesFactory,
            searchService: dependencies.searchService,
            userDefaultsService: dependencies.userDefaultsService
        )
        
        let view = SearchScreenView(state: viewState, output: presenter)
        
        return (NavigableView(view: view.eraseToAnyView()), presenter)
    }
}
