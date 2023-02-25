//
//  SettingsScreenConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

typealias SettingsScreenModule = (model: SettingsScreenModel, input: SettingsScreenInput)

struct SettingsScreenModel {
    let viewState: SettingsScreenViewState
    let viewOutput: SettingsScreenViewOutput
}

final class SettingsScreenConfigurator {
    func configure(output: SettingsScreenOutput) -> SettingsScreenModule {
        let viewState = SettingsScreenViewState()
        
        let presenter = SettingsScreenPresenter(
            viewState: viewState,
            output: output
        )
        
        let model = SettingsScreenModel(viewState: viewState, viewOutput: presenter)
        
        return (model, presenter)
    }
}
