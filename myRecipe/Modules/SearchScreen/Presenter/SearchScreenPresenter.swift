//
//  SearchScreenPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import Foundation

final class SearchScreenPresenter {
    private let viewState: SearchScreenViewState
    private weak var output: SearchScreenOutput?

    init(
        viewState: SearchScreenViewState,
        output: SearchScreenOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
}

// MARK: - SearchScreenInput

extension SearchScreenPresenter: SearchScreenInput {}

// MARK: - SearchScreenViewOutput

extension SearchScreenPresenter: SearchScreenViewOutput {}
