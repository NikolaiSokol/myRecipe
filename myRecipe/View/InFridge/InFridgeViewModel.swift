//
//  InFridgeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import UIKit

final class InFridgeViewModel {
    
    private let imageLoader: ImageLoadingManagerProtocol
    private let networkManager: InFridgeNetworkManagerProtocol

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
        }
    }
    
    var ingredients = [String]() {
        didSet {
            ingredientsChanged?()
        }
    }
    
    var autocompletions = [AutocompleteIngredient]() {
        didSet {
            autocompletionsChanged?()
        }
    }

    var recipesChanged: (() -> Void)?
    var ingredientsChanged: (() -> Void)?
    var autocompletionsChanged: (() -> Void)?
    var showingSpinner: ((Bool) -> Void)?
    var errorOccured: (() -> Void)?
    
    init(imageLoader: ImageLoadingManagerProtocol, networkManager: InFridgeNetworkManagerProtocol) {
        self.imageLoader = imageLoader
        self.networkManager = networkManager
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

    // MARK: - Recipes

    func loadRecipes() {
        isLoading = true
        networkManager.loadRecipes(ingredients: ingredients.joined(separator: ", ")) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loadedRecipes):
                    self?.recipes = loadedRecipes
                    self?.isLoading = false
                case .failure:
                    self?.errorOccured?()
                    self?.isLoading = false
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
    
    func loadIngredientImage(name: String, completion: @escaping (UIImage) -> Void) {
        imageLoader.loadImage(imageUrl: "https://spoonacular.com/cdn/ingredients_100x100/" + name) { result in
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
}
