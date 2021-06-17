//
//  HomeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.06.2021.
//

import UIKit

final class HomeViewModel {
    
    private let searchManager: SearchRecipesNetworkManager
    private let imageLoader: ImageLoadingManager
    
    private var offset = 0
    private var totalResults = 1
    
    var searchedText = "" {
        didSet {
            if !searchedText.isEmpty {
                loadAutocomplete()
            }
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
    }
    
    func loadRecipesWith(text: String) {
        if recipes.count < totalResults {
            searchManager.searchRecipesWith(text: text.lowercased(), offset: offset, number: 20) { [weak self] result in
                switch result {
                case .success(let loadedRecipes):
                    self?.recipes += loadedRecipes.results
                    self?.totalResults = loadedRecipes.totalResults
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
