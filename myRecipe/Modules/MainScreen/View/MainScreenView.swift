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
        ScrollView(.vertical, showsIndicators: false) {
            searchField
            
            carousel
        }
        .onTapGesture {
            viewState.searchFieldViewModel.endEditing()
        }
    }
    
    private var searchField: some View {
        SearchFieldView(viewModel: viewState.searchFieldViewModel)
            .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    private var carousel: some View {
        SingleSelectionCarouselView(
            viewModel: viewState.carouselViewModel,
            horizontalInsets: UIConstants.Paddings.s
        )
    }
}
