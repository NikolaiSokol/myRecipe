//
//  SearchBoxConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation

typealias SearchBoxModule = (model: SearchBoxModel, input: SearchBoxInput)

struct SearchBoxModel {
    let viewState: SearchBoxViewState
    let viewOutput: SearchBoxViewOutput
}

final class SearchBoxConfigurator {
    func configure(output: SearchBoxOutput) -> SearchBoxModule {
        let viewState = SearchBoxViewState()
        
        let presenter = SearchBoxPresenter(
            viewState: viewState,
            output: output
        )
        
        let model = SearchBoxModel(viewState: viewState, viewOutput: presenter)
        
        return (model, presenter)
    }
}
