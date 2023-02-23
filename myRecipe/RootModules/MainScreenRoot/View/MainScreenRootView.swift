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
            
            carousel
            
            recipes
            
            Spacer()
        }
        .onTapGesture {
            state.searchFieldViewModel.endEditing()
        }
    }
    
    private var header: some View {
        MainScreenHeaderView()
            .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    private var searchField: some View {
        SearchFieldView(viewModel: state.searchFieldViewModel)
            .padding(.horizontal, UIConstants.Paddings.s)
            .padding(.top, UIConstants.Paddings.m)
    }
    
    private var carousel: some View {
        SingleSelectionCarouselView(
            viewModel: state.carouselViewModel,
            horizontalInsets: UIConstants.Paddings.s
        )
        .padding(.top, UIConstants.Paddings.s)
    }
    
    private var recipes: some View {
        ScrollView(.vertical, showsIndicators: false) {
            RecipesVerticalListView(viewModel: state.recipesViewModel)
        }
        .padding(.horizontal, UIConstants.Paddings.s)
        .padding(.top, UIConstants.Paddings.xs)
    }
}
