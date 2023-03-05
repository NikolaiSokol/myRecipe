//
//  SavedRecipesRootConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//  
//

import Foundation

final class SavedRecipesRootConfigurator {
    private let dependencies: DependenciesProtocol
    
    init(dependencies: DependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func configure(router: Router, output: SavedRecipesRootOutput) -> RootModule<SavedRecipesRootInput> {
        let viewState = SavedRecipesRootViewState()
        
        let presenter = SavedRecipesRootPresenter(
            viewState: viewState,
            output: output
        )
        
        let view = SavedRecipesRootView(state: viewState, router: router, output: presenter)
        
        return (view.eraseToAnyView(), presenter)
    }
}
