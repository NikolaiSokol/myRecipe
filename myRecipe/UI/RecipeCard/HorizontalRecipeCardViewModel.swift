//
//  HorizontalRecipeCardViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 20.02.2023.
//

import SwiftUI

final class HorizontalRecipeCardViewModel: ObservableObject, Identifiable {
    let id: Int
    let imageUrl: URL?
    let name: String
    let timeToCook: String?
    let recipeCardTapHandler: (Int) -> Void
    let saveButtonTapHandler: () -> Void
    
    @Published var isSaved = false
    
    init(
        id: Int,
        imageUrl: URL?,
        name: String,
        timeToCook: String?,
        isSaved: Bool = false,
        recipeCardTapHandler: @escaping (Int) -> Void,
        saveButtonTapHandler: @escaping () -> Void
    ) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.timeToCook = timeToCook
        self.isSaved = isSaved
        self.recipeCardTapHandler = recipeCardTapHandler
        self.saveButtonTapHandler = saveButtonTapHandler
    }
    
    func didTapRecipeCard() {
        recipeCardTapHandler(id)
    }
    
    func didTapSaveButton() {
        saveButtonTapHandler()
        isSaved.toggle()
    }
}
