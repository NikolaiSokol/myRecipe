//
//  MainScreenViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenViewModel {
    private enum LocalConstants {
        static let numberOfRecipesToLoad = 5
    }
    
    private let viewState: MainScreenViewState
    private weak var output: MainScreenOutput?
    private let searchService: SearchServicing

    init(
        viewState: MainScreenViewState,
        output: MainScreenOutput,
        searchService: SearchServicing
    ) {
        self.viewState = viewState
        self.output = output
        self.searchService = searchService
    }
    
    private func setupCarousel() {
        viewState.carouselViewModel.cells = ApiConstants.AvailableMealTypes.allCases.map {
            SingleSelectionCarouselCellViewModel(
                text: $0.rawValue.capitalizingFirstLetter(),
                tapHandler: didTapCarouselCell
            )
        }
        
        viewState.carouselViewModel.cells.first?.isSelected = true
    }
    
    private func didTapCarouselCell(text: String) {
        loadRecipes(type: text)
        
        viewState.carouselViewModel.cells.forEach {
            if $0.isSelected {
                $0.isSelected = false
            }
            
            if $0.text == text {
                $0.isSelected = true
                viewState.carouselViewModel.currentSelectedId.send($0.id)
            }
        }
    }
    
    private func loadRecipes(type: String) {
        viewState.recipesViewModel.contentState = .skeleton
        
        Task {
            do {
                let recipes = try await searchService.loadRandomRecipesWithType(
                    type.lowercased(),
                    number: LocalConstants.numberOfRecipesToLoad
                )
                
                await updateRecipesList(recipes)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func handleRecipeCardTapped(id: Int) {
        print("Tapped card with id \(id)")
    }
    
    private func handleSaveRecipeTapped() {
        print("Tapped save recipe")
    }
    
    @MainActor
    private func updateRecipesList(_ recipes: [RecipeInformation]) {
        viewState.recipesViewModel.cards = recipes.map {
            HorizontalRecipeCardViewModel(
                id: $0.id,
                imageUrl: $0.imageUrl,
                name: $0.title.capitalizingFirstLetter(),
                timeToCook: $0.readyInMinutes,
                recipeCardTapHandler: handleRecipeCardTapped,
                saveButtonTapHandler: handleSaveRecipeTapped
            )
        }
        
        viewState.recipesViewModel.contentState = .content
    }
}

// MARK: - MainScreenInput

extension MainScreenViewModel: MainScreenInput {}

// MARK: - MainScreenViewOutput

extension MainScreenViewModel: MainScreenViewOutput {
    func viewAppeared() {
        setupCarousel()
        loadRecipes(type: viewState.carouselViewModel.cells.first?.text ?? "")
    }
}
