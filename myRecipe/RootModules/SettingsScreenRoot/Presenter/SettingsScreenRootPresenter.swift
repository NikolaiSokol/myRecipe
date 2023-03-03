//
//  SettingsScreenRootPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import Combine

final class SettingsScreenRootPresenter {
    private let viewState: SettingsScreenRootViewState
    private weak var output: SettingsScreenRootOutput?
    private let userDefaultsService: UserDefaultsServicing
    
    private var chosenMeasureSystemSubscription: AnyCancellable?
    private var chosenIntolerancesSubscription: AnyCancellable?
    
    init(
        viewState: SettingsScreenRootViewState,
        output: SettingsScreenRootOutput,
        userDefaultsService: UserDefaultsServicing
    ) {
        self.viewState = viewState
        self.output = output
        self.userDefaultsService = userDefaultsService
    }
    
    // MARK: - Measure System
    
    private func setupMeasureSystem() {
        viewState.chosenMeasureSystem = userDefaultsService.getMeasureSystem()
        
        subscribeToChosenMeasureSystem()
    }
    
    private func subscribeToChosenMeasureSystem() {
        chosenMeasureSystemSubscription = viewState.$chosenMeasureSystem
            .dropFirst()
            .sink { [weak self] in
                self?.userDefaultsService.saveMeasureSystem($0)
            }
    }
    
    // MARK: - Intolerances
    
    private func setupIntolerances() {
        viewState.intolerances = IntoleranceType.allCases
        viewState.chosenIntolerances = Set(userDefaultsService.getIntolerances())
        
        subscribeToChosenIntolerances()
    }
    
    private func subscribeToChosenIntolerances() {
        chosenIntolerancesSubscription = viewState.$chosenIntolerances
            .dropFirst()
            .sink { [weak self] in
                self?.userDefaultsService.saveIntolerances($0.sorted(by: <))
            }
    }
}

// MARK: - MainScreenRootInput

extension SettingsScreenRootPresenter: SettingsScreenRootInput {
    func bootstrap() {
        setupMeasureSystem()
        setupIntolerances()
    }
}

// MARK: - MainScreenNavigationViewOutput

extension SettingsScreenRootPresenter: SettingsScreenRootViewOutput {}
