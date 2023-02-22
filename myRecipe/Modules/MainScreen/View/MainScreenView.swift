//
//  MainScreenView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject private var viewState: MainScreenViewState
    private let output: MainScreenViewOutput?
    
    init(
        viewState: MainScreenViewState,
        output: MainScreenViewOutput?
    ) {
        self.viewState = viewState
        self.output = output
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            header
            
            searchField
            
            carousel
            
            recipes
            
            Spacer()
        }
        .onAppear {
            output?.onViewAppear()
        }
        .onTapGesture {
            viewState.searchFieldViewModel.endEditing()
        }
    }
    
    private var header: some View {
        MainScreenHeaderView()
            .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    private var searchField: some View {
        SearchFieldView(viewModel: viewState.searchFieldViewModel)
            .padding(.horizontal, UIConstants.Paddings.s)
            .padding(.top, UIConstants.Paddings.m)
    }
    
    private var carousel: some View {
        SingleSelectionCarouselView(
            viewModel: viewState.carouselViewModel,
            horizontalInsets: UIConstants.Paddings.s
        )
        .padding(.top, UIConstants.Paddings.s)
    }
    
    private var recipes: some View {
        ScrollView(.vertical, showsIndicators: false) {
            RecipesVerticalListView(viewModel: viewState.recipesViewModel)
        }
        .padding(.horizontal, UIConstants.Paddings.s)
        .padding(.top, UIConstants.Paddings.xs)
    }
}
