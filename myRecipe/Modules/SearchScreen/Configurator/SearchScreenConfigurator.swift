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
    
    init(dependencies: DependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func configure(output: SearchScreenOutput) -> NavigableModule<SearchScreenInput> {
        let viewState = SearchScreenViewState()
        
        let presenter = SearchScreenPresenter(
            viewState: viewState,
            output: output
        )
        
        let view = SearchScreenView(state: viewState, output: presenter)
        
        return (NavigableView(view: view.eraseToAnyView()), presenter)
    }
}
