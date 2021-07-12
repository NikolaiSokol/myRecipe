//
//  RecipeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 04.07.2021.
//

import Foundation

final class RecipeViewModel {
    
    private let imageLoader: ImageLoadingManager
    
    init(imageLoader: ImageLoadingManager) {
        self.imageLoader = imageLoader
    }
}
