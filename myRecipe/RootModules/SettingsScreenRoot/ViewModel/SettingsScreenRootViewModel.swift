//
//  SettingsScreenRootViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class SettingsScreenRootViewModel {
    private let viewState: SettingsScreenRootViewState
    private weak var output: SettingsScreenRootOutput?
    private let modulesFactory: ModulesFactoring
    
    private var settingsScreenInput: SettingsScreenInput?
    
    init(
        viewState: SettingsScreenRootViewState,
        output: SettingsScreenRootOutput,
        modulesFactory: ModulesFactoring
    ) {
        self.viewState = viewState
        self.output = output
        self.modulesFactory = modulesFactory
    }
    
    private func setupSettingsScreen() {
        let unit = modulesFactory.makeSettingsScreen(output: self)
        
        settingsScreenInput = unit.input
        viewState.settingsScreenModel = unit.model
    }
}

// MARK: - MainScreenRootInput

extension SettingsScreenRootViewModel: SettingsScreenRootInput {
    func bootstrap() {
        setupSettingsScreen()
    }
}

// MARK: - MainScreenNavigationViewOutput

extension SettingsScreenRootViewModel: SettingsScreenRootViewOutput {}

// MARK: - SettingsScreenOutput

extension SettingsScreenRootViewModel: SettingsScreenOutput {}
