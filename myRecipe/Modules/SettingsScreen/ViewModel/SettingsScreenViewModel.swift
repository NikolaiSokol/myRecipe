//
//  SettingsScreenViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class SettingsScreenViewModel {
    private let viewState: SettingsScreenViewState
    private weak var output: SettingsScreenOutput?

    init(
        viewState: SettingsScreenViewState,
        output: SettingsScreenOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
}

// MARK: - SettingsScreenInput

extension SettingsScreenViewModel: SettingsScreenInput {}

// MARK: - SettingsScreenViewOutput

extension SettingsScreenViewModel: SettingsScreenViewOutput {}
