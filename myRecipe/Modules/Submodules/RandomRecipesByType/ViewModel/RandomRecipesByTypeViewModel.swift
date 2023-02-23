//
//  RandomRecipesByTypeViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation

final class RandomRecipesByTypeViewModel {
    private enum LocalConstants {
        static let numberOfRecipesToLoad = 7
    }
    
    private let viewState: RandomRecipesByTypeViewState
    private weak var output: RandomRecipesByTypeOutput?
    private let randomRecipesService: RandomRecipesServicing
    
    private var recipesLoadingTask: Task<Void, Never>?
    private var currentSelectedType = ""
    
    init(
        viewState: RandomRecipesByTypeViewState,
        output: RandomRecipesByTypeOutput,
        randomRecipesService: RandomRecipesServicing
    ) {
        self.viewState = viewState
        self.output = output
        self.randomRecipesService = randomRecipesService
    }
    
    // MARK: - Recipe Type Carousel
    
    private func setupCarousel() {
        viewState.carouselViewModel.cells = ApiConstants.AvailableMealTypes.allCases.map {
            SingleSelectionCarouselCellViewModel(
                text: $0.rawValue.capitalizingFirstLetter(),
                tapHandler: didTapCarouselCell
            )
        }
        
        viewState.carouselViewModel.cells.first?.isSelected = true
        currentSelectedType = viewState.carouselViewModel.cells.first?.text ?? ""
    }
    
    private func didTapCarouselCell(text: String) {
        let didTapTheSameCell = currentSelectedType == text
        
        guard !didTapTheSameCell else {
            viewState.recipesViewModel.scrollToTop()
            return
        }
        
        currentSelectedType = text
        cancelTasks()
        loadRecipes()
        
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
    
    // MARK: - Random Recipes
    
    private func loadRecipes(withSkeleton: Bool = true) {
        guard recipesLoadingTask.isNil else {
            return
        }
        
        if withSkeleton {
            viewState.recipesViewModel.contentState = .skeleton
        }
        
        recipesLoadingTask = Task {
            do {
                let recipes = try await randomRecipesService.loadWithType(
                    currentSelectedType.lowercased(),
                    number: LocalConstants.numberOfRecipesToLoad
                )

                await updateRecipesList(recipes)

            } catch {
                await showErrorScreen()
            }

            recipesLoadingTask = nil
        }
    }
    
    private func handleRecipeCardTapped(id: Int) {
        output?.randomRecipesByTypeDidRequest(event: .openRecipe(id: id))
    }
    
    private func handleSaveRecipeTapped() {
        print("Tapped save recipe")
    }
    
    @MainActor private func updateRecipesList(_ recipes: [RecipeInformation]) {
        guard !recipes.isEmpty else {
            showErrorScreen()
            return
        }
        
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
        
        viewState.recipesViewModel.refreshHandler = { [weak self] in
            self?.loadRecipes(withSkeleton: false)
        }
        
        viewState.recipesViewModel.contentState = .content
    }
    
    // MARK: - Error Screen
    
    @MainActor private func showErrorScreen() {
        let errorViewModel = ErrorViewModel(
            title: "somethingWentWrong".localized(),
            buttonText: "tryAgain".localized()) { [weak self] in
                self?.loadRecipes()
                self?.viewState.recipesViewModel.errorViewModel = nil
            }
        
        viewState.recipesViewModel.errorViewModel = errorViewModel
        viewState.recipesViewModel.contentState = .error
    }
    
    // MARK: - Helpers
    
    private func cancelTasks() {
        recipesLoadingTask?.cancel()
        recipesLoadingTask = nil
    }
}

// MARK: - RandomRecipesByTypeInput

extension RandomRecipesByTypeViewModel: RandomRecipesByTypeInput {
    func bootstrap() {
        setupCarousel()
        loadRecipes()
    }
}

// MARK: - RandomRecipesByTypeViewOutput

extension RandomRecipesByTypeViewModel: RandomRecipesByTypeViewOutput {}
