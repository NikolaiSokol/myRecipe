//
//  SearchViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.06.2021.
//

import UIKit

final class SearchViewModel {
    
    private enum LastSearchType {
        case withText
        case withParameters
    }
    
    private let searchManager: SearchRecipesNetworkManager
    private let imageLoader: ImageLoadingManager
    
    private var lastSearch: LastSearchType
    
    private var offset = 0
    private var totalResults = 1
    
    var searchedText = "" {
        didSet {
            if !searchedText.isEmpty {
                loadAutocomplete()
            }
        }
    }
    
    var searchParameters: RecipesSearchParameters? {
        didSet {
            loadRecipesWithParameters()
        }
    }
    
    @Published var recipes = [SearchedRecipe]() {
        didSet {
            offset = recipes.count
        }
    }
    
    @Published var autocompletions = [AutocompleteRecipeSearchResponse]()
    
    @Published var isLoading = false
    @Published var errorOccured = false
    
    init(searchManager: SearchRecipesNetworkManager, imageLoader: ImageLoadingManager) {
        self.searchManager = searchManager
        self.imageLoader = imageLoader
        lastSearch = .withText
    }
    
    // MARK: - Recipes
    
    func loadRecipesWithText() {
        if recipes.count < totalResults {
            isLoading = true
            searchManager.searchRecipesWith(text: searchedText.lowercased(), offset: offset, number: 20) { [weak self] result in
                switch result {
                case .success(let loadedRecipes):
                    self?.lastSearch = .withText
                    self?.recipes += loadedRecipes.results
                    self?.totalResults = loadedRecipes.results.isEmpty ? 1 : loadedRecipes.totalResults
                    self?.isLoading = false
                case .failure:
                    self?.errorOccured = true
                    self?.isLoading = false
                }
            }
        }
    }
    
    func loadRecipesWithParameters() {
        guard let parameters = searchParameters else { return }
        
        if recipes.count < totalResults {
            isLoading = true
            searchManager.searchRecipesWith(parameters: parameters, offset: offset, number: 20) { [weak self] result in
                switch result {
                case .success(let loadedRecipes):
                    self?.lastSearch = .withParameters
                    self?.recipes += loadedRecipes.results
                    self?.totalResults = loadedRecipes.results.isEmpty ? 1 : loadedRecipes.totalResults
                    self?.isLoading = false
                case .failure:
                    self?.errorOccured = true
                    self?.isLoading = false
                }
            }
        }
    }
    
    func loadMoreRecipes() {
        if !recipes.isEmpty && !isLoading {
            switch lastSearch {
            case .withText:
                loadRecipesWithText()
            case .withParameters:
                loadRecipesWithParameters()
            }
        }
    }
    
    // MARK: - Autocomplete
    
    func loadAutocomplete() {
        print("chlen")
        searchManager.loadAutocomplete(text: searchedText.lowercased()) { [weak self] result in
            switch result {
            case .success(let autocompletions):
                self?.autocompletions = autocompletions
            case .failure:
                self?.errorOccured = true
            }
        }
    }
    
    // MARK: - Image
    
    func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
        imageLoader.loadImage(imageUrl: url) { loadedImage in
            DispatchQueue.main.async {
                completion(loadedImage)
            }
        }
    }
}
