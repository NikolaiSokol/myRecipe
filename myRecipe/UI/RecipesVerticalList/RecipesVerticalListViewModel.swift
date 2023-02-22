//
//  RecipesVerticalListViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

final class RecipesVerticalListViewModel: ObservableObject {
    @Published var cards: [HorizontalRecipeCardViewModel] = []
    @Published var contentState: ViewContentState = .skeleton
    
    var errorViewModel: ErrorViewModel?
}
