//
//  SettingsScreenPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class SettingsScreenPresenter {
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

extension SettingsScreenPresenter: SettingsScreenInput {}

// MARK: - SettingsScreenViewOutput

extension SettingsScreenPresenter: SettingsScreenViewOutput {}
