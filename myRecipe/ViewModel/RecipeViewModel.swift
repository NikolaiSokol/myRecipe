//
//  RecipeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 04.07.2021.
//

import UIKit

final class RecipeViewModel {
    
    private let recipeManager = RecipeNetworkManager()
    private let imageLoader: ImageLoadingManager
    private let recipeId: Int
    
    private var isLoading = false {
        didSet {
            showingSpinner?(isLoading)
        }
    }
    
    var recipe: RecipeResponse? {
        didSet {
            recipeLoaded?()
        }
    }
    
    var recipeLoaded: (() -> Void)?
    var showingSpinner: ((Bool) -> Void)?
    var errorOccured: (() -> Void)?
    
    init(imageLoader: ImageLoadingManager, recipeId: Int) {
        self.imageLoader = imageLoader
        self.recipeId = recipeId
    }
    
    func loadRecipe() {
        isLoading = true
        recipeManager.loadRecipe(id: recipeId) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let recipe):
                    self?.recipe = recipe
                    self?.isLoading = false
                case .failure:
                    self?.errorOccured?()
                    self?.isLoading = false
                }
            }
        }
    }
    
    // MARK: - Image
    
    func loadMainImage(completion: @escaping (UIImage) -> Void) {
        guard let recipe = recipe else {
            errorOccured?()
            return
        }
        
        imageLoader.loadImage(imageUrl: recipe.image) { result in
            DispatchQueue.main.async {  [weak self] in
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
        imageLoader.loadImage(imageUrl: "https://spoonacular.com/cdn/ingredients_100x100/" + name) { result in
            DispatchQueue.main.async {  [weak self] in
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
