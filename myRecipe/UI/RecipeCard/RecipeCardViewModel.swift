//
//  RecipeCardViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 20.02.2023.
//

import SwiftUI

final class RecipeCardViewModel: ObservableObject {
    let image: Image
    let name: String
    let timeToCook: String
    let recipeCardTapHandler: () -> Void
    let saveButtonTapHandler: () -> Void
    
    @Published var isSaved = false
    
    init(
        image: Image,
        name: String,
        timeToCook: String,
        isSaved: Bool = false,
        recipeCardTapHandler: @escaping () -> Void,
        saveButtonTapHandler: @escaping () -> Void
    ) {
        self.image = image
        self.name = name
        self.timeToCook = timeToCook
        self.isSaved = isSaved
        self.recipeCardTapHandler = recipeCardTapHandler
        self.saveButtonTapHandler = saveButtonTapHandler
    }
    
    func didTapRecipeCard() {
        recipeCardTapHandler()
    }
    
    func didTapSaveButton() {
        saveButtonTapHandler()
        isSaved.toggle()
    }
}
