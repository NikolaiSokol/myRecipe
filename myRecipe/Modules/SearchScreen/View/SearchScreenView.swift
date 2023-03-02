//
//  SearchScreenView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import SwiftUI

struct SearchScreenView: View {
    private enum LocalConstants {
        static let topSectionSizeNameSpace = "SearchScreenViewSearchBoxNameSpace"
        static let sortAndFiltersImageSize: CGFloat = 12
    }
    
    @ObservedObject private var state: SearchScreenViewState
    private weak var output: SearchScreenViewOutput?
    
    @State private var topSectionSize: CGSize = .zero
    @State private var sortingSheetSize: CGSize = .zero
    
    init(
        state: SearchScreenViewState,
        output: SearchScreenViewOutput
    ) {
        self.state = state
        self.output = output
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: UIConstants.Paddings.xs) {
                searchBox
                
                sortAndFilters
            }
            .getViewSize($topSectionSize, spaceName: LocalConstants.topSectionSizeNameSpace)
            
            recipesList
            
            searchSuggestions
        }
        .sheet(isPresented: $state.isShowingSorting) {
            SortingView(viewModel: state.sortingViewModel, contentSize: $sortingSheetSize)
                .presentationDetents([.height(sortingSheetSize.height)])
                .presentationDragIndicator(.visible)
                .padding(.horizontal, UIConstants.Paddings.s)
        }
        .sheet(isPresented: $state.isShowingFilters) {
            FiltersView(viewModel: state.filtersViewModel)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .padding(.horizontal, UIConstants.Paddings.s)
        }
        .navigationBarHidden(true)
        .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    @ViewBuilder private var searchBox: some View {
        if let output, let model = state.searchBoxModel {
            HStack {
                SearchBoxView(state: model.viewState, output: model.viewOutput)
                
                Button(action: output.didTapCancel) {
                    Text(String(localized: .cancel))
                        .customFont(size: UIConstants.Font.s)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.primaryAccent))
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    @ViewBuilder private var recipesList: some View {
        if !state.isShowingSearchSuggestions {
            RecipesVerticalListView(viewModel: state.recipesViewModel)
                .padding(.top, topSectionSize.height)
                .onTapGesture {
                    output?.endEditing()
                }
        }
    }
    
    @ViewBuilder private var searchSuggestions: some View {
        if state.isShowingSearchSuggestions {
            SearchSuggestionsView(viewModel: state.suggestionsViewModel)
                .padding(.top, topSectionSize.height + UIConstants.Paddings.xs)
                .onTapGesture {
                    output?.endEditing()
                }
        }
    }
    
    @ViewBuilder private var sortAndFilters: some View {
        if state.isShowingSortAndFiltersButtons,
           !state.isShowingSearchSuggestions {
            VStack(spacing: UIConstants.Paddings.xs) {
                HStack {
                    sortingButton
                    
                    Spacer()
                    
                    filtersButton
                }
                .foregroundColor(Color(.primaryAccent))
                
                Separator()
            }
        }
    }
    
    private var sortingButton: some View {
        Button(action: state.didTapShowSorting) {
            HStack(spacing: UIConstants.Paddings.xxxs) {
                Image(systemName: "arrow.up.arrow.down")
                    .resizable()
                    .scaledToFit()
                    .frame(height: LocalConstants.sortAndFiltersImageSize)
                
                Text(state.sortingViewModel.selectedOption.localizedString().capitalizingFirstLetter())
                    .customFont(size: UIConstants.Font.s)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    private var filtersButton: some View {
        Button(action: state.didTapShowFilters) {
            HStack(spacing: UIConstants.Paddings.xxxs) {
                Text(String(localized: .filters))
                    .customFont(size: UIConstants.Font.s)
                
                Image(systemName: "slider.vertical.3")
                    .resizable()
                    .scaledToFit()
                    .frame(height: LocalConstants.sortAndFiltersImageSize)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
