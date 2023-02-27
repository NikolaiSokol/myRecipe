//
//  SearchScreenCoordinator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

final class SearchScreenCoordinator {
    private weak var output: SearchScreenCoordinatorOutput?
    private let modulesFactory: ModulesFactoring
    private let router: Routable
    
    private var searchScreenInput: SearchScreenInput?
    
    init(
        output: SearchScreenCoordinatorOutput?,
        modulesFactory: ModulesFactoring,
        router: Routable
    ) {
        self.output = output
        self.modulesFactory = modulesFactory
        self.router = router
    }
    
    private func showSearchScreen() {
        let unit = modulesFactory.makeSearchScreen(output: self)
        searchScreenInput = unit.input
        router.present(unit.view)
    }
}

extension SearchScreenCoordinator: Coordinator {
    func start(with option: CoordinatorOption?) {
        showSearchScreen()
    }
}

// MARK: - SearchScreenCoordinatorInput

extension SearchScreenCoordinator: SearchScreenCoordinatorInput {}

// MARK: - SearchScreenOutput

extension SearchScreenCoordinator: SearchScreenOutput {}
