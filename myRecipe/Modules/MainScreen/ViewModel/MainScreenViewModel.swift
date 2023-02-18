//
//  MainScreenViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenViewModel {
    private let viewState: MainScreenViewState
    private weak var output: MainScreenOutput?

    init(
        viewState: MainScreenViewState,
        output: MainScreenOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
}

// MARK: - MainScreenInput

extension MainScreenViewModel: MainScreenInput {}

// MARK: - MainScreenViewOutput

extension MainScreenViewModel: MainScreenViewOutput {}
