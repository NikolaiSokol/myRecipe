//
//  MainScreenViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenViewState: ObservableObject {
    let searchFieldViewModel = SearchFieldViewModel()
    let carouselViewModel = SingleSelectionCarouselViewModel()
    let recipesViewModel = RecipesVerticalListViewModel()
}
