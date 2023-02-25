//
//  TabBarPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import Combine

final class TabBarPresenter {
    private let viewState: TabBarViewState
    private weak var output: TabBarOutput?
    
    private var selectedTab = TabBarElementType.mainScreenRoot
    
    private var selectedTabSubscription: AnyCancellable?
    
    init(
        viewState: TabBarViewState,
        output: TabBarOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
    
    private func subscribeToSelectedTab() {
        selectedTabSubscription = viewState.$selectedTab
            .sink { [weak self] in
                if self?.selectedTab == $0 {
                    self?.output?.didTapSelectedTab($0)
                } else {
                    self?.selectedTab = $0
                }
            }
    }
}

// MARK: - TabBarInput

extension TabBarPresenter: TabBarInput {
    func updateTabs(_ tabs: [TabBarElement]) {
        subscribeToSelectedTab()
        viewState.tabs = tabs
    }
}

// MARK: - TabBarViewOutput

extension TabBarPresenter: TabBarViewOutput {}
