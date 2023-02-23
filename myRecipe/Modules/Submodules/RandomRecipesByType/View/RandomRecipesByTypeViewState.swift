//
//  RandomRecipesByTypeViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation

final class RandomRecipesByTypeViewState: ObservableObject {
    let carouselViewModel = SingleSelectionCarouselViewModel()
    let recipesViewModel = RecipesVerticalListViewModel()
}
