//
//  MainScreenRootView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

struct MainScreenRootView: View {
    @ObservedObject private var state: MainScreenRootViewState
    @ObservedObject private var router: Router
    
    private let output: MainScreenRootViewOutput
    
    init(
        state: MainScreenRootViewState,
        router: Router,
        output: MainScreenRootViewOutput
    ) {
        self.state = state
        self.router = router
        self.output = output
    }
    
    var body: some View {
        if let model = state.mainScreenModel {
            NavigationStack(path: $router.navigableViews) {
                MainScreenView(viewState: model.viewState, output: model.viewOutput)
                    .navigationDestination(for: NavigableView.self) {
                        $0.view
                    }
            }
        }
    }
}
