//
//  SearchSuggestionsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 28.02.2023.
//

import SwiftUI

struct SearchSuggestionsView: View {
    private enum LocalConstants {
        static let clearButtonSize: CGFloat = 14
    }
    
    @ObservedObject private var viewModel: SearchSuggestionsViewModel
    
    init(viewModel: SearchSuggestionsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: .zero) {
                history
                
                autocompletes
            }
        }
    }
    
    @ViewBuilder private var history: some View {
        if viewModel.autocompletes.isEmpty,
           !viewModel.historySearches.isEmpty {
            historyTitle
            
            Separator()
                .padding(.vertical, UIConstants.Paddings.s)
            
            ForEach(viewModel.historySearches, id: \.id) {
                cell($0, withClearButton: true)
            }
        }
    }
    
    private var historyTitle: some View {
        HStack {
            Text(String(localized: .previousSearches))
                .customFont(size: UIConstants.Font.l)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: viewModel.didTapRemoveAllHistory) {
                clearButtonImage
            }
            .buttonStyle(.plain)
        }
    }
    
    private var autocompletes: some View {
        ForEach(viewModel.autocompletes, id: \.id) {
            cell($0)
        }
    }
    
    private var clearButtonImage: some View {
        Image(systemName: "xmark")
            .resizable()
            .scaledToFit()
            .fontWeight(.semibold)
            .foregroundColor(Color(.accentGray))
            .frame(height: LocalConstants.clearButtonSize)
    }
    
    private func cell(
        _ item: SearchAutocomplete,
        withClearButton: Bool = false
    ) -> some View {
        HStack {
            Button {
                viewModel.didTapSuggestion(text: item.text)
            } label: {
                cellContent(text: item.text)
            }
            .buttonStyle(.plain)
            
            if withClearButton {
                Button {
                    viewModel.didTapRemoveHistorySuggestion(text: item.text)
                } label: {
                    clearButtonImage
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private func cellContent(text: String) -> some View {
        HStack {
            Text(text.capitalizingFirstLetter())
                .customFont(size: UIConstants.Font.m)
                .foregroundColor(Color(.textAccent))
            
            Spacer()
        }
        .padding(.vertical, UIConstants.Paddings.xxs)
        .contentShape(Rectangle())
    }
}

struct SearchSuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchSuggestionsViewModel()
        viewModel.historySearches = [
            SearchAutocomplete(id: 0, text: "history one"),
            SearchAutocomplete(id: 1, text: "history two"),
            SearchAutocomplete(id: 2, text: "history three")
        ]
        viewModel.autocompletes = [
            SearchAutocomplete(id: 0, text: "one"),
            SearchAutocomplete(id: 1, text: "two"),
            SearchAutocomplete(id: 2, text: "three")
        ]
        
        return SearchSuggestionsView(viewModel: viewModel)
    }
}
