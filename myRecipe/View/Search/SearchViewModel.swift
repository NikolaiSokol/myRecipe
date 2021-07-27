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
    
    private let networkManager: SearchRecipesNetworkManagerProtocol
    private let imageLoader: ImageLoadingManagerProtocol
    
    private var lastSearch: LastSearchType
    
    private var offset = 0
    private var totalResults = 1
    
    private var searchParameters: RecipesSearchParameters? {
        didSet {
            loadRecipesWithParameters()
        }
    }
    
    private var isLoading = false {
        didSet {
            showingSpinner?(isLoading)
        }
    }
    
    var searchedText = "" {
        didSet {
            if !searchedText.isEmpty {
                loadAutocomplete()
            }
        }
    }
    
    var recipes = [SearchedRecipe]() {
        didSet {
            recipesChanged?()
            offset = recipes.count
        }
    }
    
    var autocompletions = [AutocompleteRecipeSearch]() {
        didSet {
            autocompletionsChanged?()
        }
    }
    
    var recipesChanged: (() -> Void)?
    var autocompletionsChanged: (() -> Void)?
    var showingSpinner: ((Bool) -> Void)?
    var errorOccured: (() -> Void)?
    
    init(networkManager: SearchRecipesNetworkManagerProtocol, imageLoader: ImageLoadingManagerProtocol) {
        self.networkManager = networkManager
        self.imageLoader = imageLoader
        lastSearch = .withText
        loadRandomRecipes()
    }
    
    // MARK: - Recipes

    func loadRandomRecipes() {
        isLoading = true
        networkManager.loadRandomRecipes { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loadedRandom):
                    self?.recipes = loadedRandom.recipes
                    self?.isLoading = false
                case .failure:
                    self?.errorOccured?()
                    self?.isLoading = false
                }
            }
        }
    }
    
    func loadRecipesWithText() {
        if offset < totalResults {
            isLoading = true
            networkManager.searchRecipesWith(text: searchedText.lowercased(), offset: offset, number: 20) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let loadedRecipes):
                        self?.lastSearch = .withText
                        self?.recipes += loadedRecipes.results
                        self?.totalResults = loadedRecipes.results.isEmpty ? 1 : loadedRecipes.totalResults
                        self?.isLoading = false
                    case .failure:
                        self?.errorOccured?()
                        self?.isLoading = false
                    }
                }
            }
        }
    }
    
    func loadRecipesWithParameters() {
        guard let parameters = searchParameters else { return }
        
        if offset < totalResults {
            isLoading = true
            networkManager.searchRecipesWith(parameters: parameters, offset: offset, number: 20) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let loadedRecipes):
                        self?.lastSearch = .withParameters
                        self?.recipes += loadedRecipes.results
                        self?.totalResults = loadedRecipes.results.isEmpty ? 1 : loadedRecipes.totalResults
                        self?.isLoading = false
                    case .failure:
                        self?.errorOccured?()
                        self?.isLoading = false
                    }
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
    
    private func loadAutocomplete() {
        networkManager.loadAutocomplete(text: searchedText.lowercased()) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let autocompletions):
                    self?.autocompletions = autocompletions
                case .failure:
                    break
                }
            }
        }
    }
    
    // MARK: - Image
    
    func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
        imageLoader.loadImage(imageUrl: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loadedImage):
                    completion(loadedImage)
                case .failure:
                    break
                }
            }
        }
    }
    
    // MARK: - Search Parameters
    
    func setSearchParameters(_ parameters: RecipesSearchParameters) {
        searchParameters = parameters
    }
}
