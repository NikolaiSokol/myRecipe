//
//  InFridgeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import UIKit

final class InFridgeViewModel {
    
    private let imageLoader: ImageLoadingManager
    private let networkManager = InFridgeNetworkManager()

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
    
    var autocompletions = [AutocompleteIngredientResponse]() {
        didSet {
            autocompletionsChanged?()
        }
    }

    var recipesChanged: (() -> Void)?
    var ingredientsChanged: (() -> Void)?
    var autocompletionsChanged: (() -> Void)?
    var showingSpinner: ((Bool) -> Void)?
    var errorOccured: (() -> Void)?
    
    init(imageLoader: ImageLoadingManager) {
        self.imageLoader = imageLoader
    }

    // MARK: - Autocomplete
    
    private func loadAutocomplete() {
        networkManager.loadAutocomplete(text: searchedText.lowercased()) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let autocompletions):
                    self?.autocompletions = autocompletions
                case .failure:
                    self?.errorOccured?()
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
        imageLoader.loadImage(imageUrl: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loadedImage):
                    completion(loadedImage)
                case .failure:
                    self?.errorOccured?()
                }
            }
        }
    }
    
    func loadIngredientImage(name: String, completion: @escaping (UIImage) -> Void) {
        imageLoader.loadImage(imageUrl: "https://spoonacular.com/cdn/ingredients_100x100/" + name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loadedImage):
                    completion(loadedImage)
                case .failure:
                    self?.errorOccured?()
                }
                
            }
        }
    }
}
