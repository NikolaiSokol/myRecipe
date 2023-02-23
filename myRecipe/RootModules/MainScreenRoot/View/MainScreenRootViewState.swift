//
//  MainScreenRootViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenRootViewState: ObservableObject {
    let searchFieldViewModel = SearchFieldViewModel()
    let carouselViewModel = SingleSelectionCarouselViewModel()
    let recipesViewModel = RecipesVerticalListViewModel()
}
