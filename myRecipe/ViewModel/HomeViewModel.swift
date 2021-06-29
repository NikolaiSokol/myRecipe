//
//  HomeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.06.2021.
//

import UIKit

final class HomeViewModel {
    
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
            recipes.removeAll()
            
            if !searchedText.isEmpty {
                loadAutocomplete()
            }
        }
    }
    
    var searchParameters: RecipesSearchParameters? {
        didSet {
            recipes.removeAll()
        }
    }
    
    @Published var recipes = [SearchedRecipe]() {
        didSet {
            offset = recipes.count
        }
    }
    @Published var autocompletions = [AutocompleteRecipeSearchResponse]()
    
    init(searchManager: SearchRecipesNetworkManager, imageLoader: ImageLoadingManager) {
        self.searchManager = searchManager
        self.imageLoader = imageLoader
        lastSearch = .withText
    }
    
    func loadRecipesWithText() {
        if recipes.count < totalResults {
            searchManager.searchRecipesWith(text: searchedText.lowercased(), offset: offset, number: 20) { [weak self] result in
                switch result {
                case .success(let loadedRecipes):
                    self?.lastSearch = .withText
                    self?.recipes += loadedRecipes.results
                    self?.totalResults = loadedRecipes.totalResults
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadRecipesWithParameters() {
        guard let parameters = searchParameters else { return }
        
        if recipes.count < totalResults {
            searchManager.searchRecipesWith(parameters: parameters, offset: offset, number: 20) { [weak self] result in
                switch result {
                case .success(let loadedRecipes):
                    self?.lastSearch = .withParameters
                    self?.recipes += loadedRecipes.results
                    self?.totalResults = loadedRecipes.totalResults
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadMoreRecipes() {
        if !recipes.isEmpty {
            switch lastSearch {
            case .withText:
                loadRecipesWithText()
            case .withParameters:
                loadRecipesWithParameters()
            }
        }
    }
    
    func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
        imageLoader.loadImage(imageUrl: url) { loadedImage in
            DispatchQueue.main.async {
                completion(loadedImage)
            }
        }
    }
    
    func loadAutocomplete() {
        searchManager.loadAutocomplete(text: searchedText.lowercased()) { [weak self] result in
            switch result {
            case .success(let autocompletions):
                self?.autocompletions = autocompletions
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
