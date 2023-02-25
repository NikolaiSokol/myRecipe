//
//  SearchBoxPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation

final class SearchBoxPresenter {
    private let viewState: SearchBoxViewState
    private weak var output: SearchBoxOutput?

    init(
        viewState: SearchBoxViewState,
        output: SearchBoxOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
}

// MARK: - SearchBoxInput

extension SearchBoxPresenter: SearchBoxInput {
    func endEditing() {
        viewState.endEditing()
    }
}

// MARK: - SearchBoxViewOutput

extension SearchBoxPresenter: SearchBoxViewOutput {}
