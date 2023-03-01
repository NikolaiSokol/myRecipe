//
//  SearchScreenViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import Foundation

final class SearchScreenViewState: ObservableObject {
    @Published var searchBoxModel: SearchBoxModel?
    @Published var isShowingSearchSuggestions = true
    @Published var isShowingSortAndFiltersButtons = false
    @Published var isShowingSorting = false
    
    let suggestionsViewModel = SearchSuggestionsViewModel()
    let recipesViewModel = RecipesVerticalListViewModel()
    let sortingViewModel = SortingViewModel()
    
    var showSortingTapHandler: (() -> Void)?
    var showFiltersTapHandler: (() -> Void)?
    
    func updateIsShowingSearchSuggestions(to newValue: Bool) {
        if isShowingSearchSuggestions != newValue {
            isShowingSearchSuggestions = newValue
        }
    }
    
    func updateIsShowingSortAndFiltersButtons(to newValue: Bool) {
        if isShowingSortAndFiltersButtons != newValue {
            isShowingSortAndFiltersButtons = newValue
        }
    }
    
    func didTapShowSorting() {
        showSortingTapHandler?()
    }
    
    func didTapShowFilters() {
        showFiltersTapHandler?()
    }
}
