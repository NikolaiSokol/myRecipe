//
//  SearchSuggestionsViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 28.02.2023.
//

import Foundation

final class SearchSuggestionsViewModel: ObservableObject {
    @Published var historySearches: [SearchAutocomplete] = []
    @Published var autocompletes: [SearchAutocomplete] = []
    
    var tapHandler: ((String) -> Void)?
    var clearAllHistoryHandler: (() -> Void)?
    var clearHistorySuggestionHandler: ((String) -> Void)?
    
    func didTapSuggestion(text: String) {
        tapHandler?(text)
    }
    
    func didTapRemoveAllHistory() {
        clearAllHistoryHandler?()
    }
    
    func didTapRemoveHistorySuggestion(text: String) {
        clearHistorySuggestionHandler?(text)
    }
}
