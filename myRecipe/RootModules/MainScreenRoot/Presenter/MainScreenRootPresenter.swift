//
//  MainScreenRootPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenRootPresenter {
    private let viewState: MainScreenRootViewState
    private weak var output: MainScreenRootOutput?
    private let modulesFactory: ModulesFactoring

    private var randomRecipesByTypeInput: RandomRecipesByTypeInput?
    
    init(
        viewState: MainScreenRootViewState,
        output: MainScreenRootOutput,
        modulesFactory: ModulesFactoring
    ) {
        self.viewState = viewState
        self.output = output
        self.modulesFactory = modulesFactory
    }
    
    private func setupSubmodules() {
        setupSearchButton()
        setupRandomRecipesByType()
    }
    
    private func setupSearchButton() {
        viewState.searchButtonTapHandler = { [weak self] in
            self?.output?.mainScreenRootDidRequest(event: .openSearch)
        }
    }
    
    private func setupRandomRecipesByType() {
        let unit = modulesFactory.makeRandomRecipesByType(output: self)
        
        randomRecipesByTypeInput = unit.input
        viewState.randomRecipesByTypeModel = unit.model
        
        randomRecipesByTypeInput?.bootstrap()
    }
}

// MARK: - MainScreenRootInput

extension MainScreenRootPresenter: MainScreenRootInput {
    func bootstrap() {
        setupSubmodules()
    }
}

// MARK: - MainScreenNavigationViewOutput

extension MainScreenRootPresenter: MainScreenRootViewOutput {}

// MARK: - RandomRecipesByTypeOutput

extension MainScreenRootPresenter: RandomRecipesByTypeOutput {
    func randomRecipesByTypeDidRequest(event: RandomRecipesByTypeEvent) {
        switch event {
        case let .openRecipe(recipe):
            output?.mainScreenRootDidRequest(event: .openRecipe(recipe))
            
        case .tappedCarouselCell:
            viewState.showTopSectionSubject.send()
        }
    }
}
