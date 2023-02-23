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
        NavigationStack(path: $router.navigableViews) {
            actualBody
                .navigationDestination(for: NavigableView.self) {
                    $0.view
                }
        }
    }
    
    private var actualBody: some View {
        VStack(spacing: .zero) {
            header
            
            searchField
            
            randomRecipesByType
            
            Spacer()
        }
        .onTapGesture {
            output.endEditing()
        }
    }
    
    private var header: some View {
        MainScreenHeaderView()
            .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    @ViewBuilder private var searchField: some View {
        if let model = state.searchBoxModel {
            SearchBoxView(state: model.viewState, output: model.viewOutput)
                .padding(.horizontal, UIConstants.Paddings.s)
                .padding(.top, UIConstants.Paddings.m)
        }
    }
    
    @ViewBuilder private var randomRecipesByType: some View {
        if let model = state.randomRecipesByTypeModel {
            RandomRecipesByTypeView(state: model.viewState, output: model.viewOutput)
                .padding(.top, UIConstants.Paddings.s)
        }
    }
}
