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
    
    let suggestionsViewModel = SearchSuggestionsViewModel()
    let recipesViewModel = RecipesVerticalListViewModel()
    
    func updateIsShowingSearchSuggestions(to newValue: Bool) {
        if isShowingSearchSuggestions != newValue {
            isShowingSearchSuggestions = newValue
        }
    }
}
