//
//  MainScreenRootViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenRootViewModel {
    private enum LocalConstants {
        static let numberOfRecipesToLoad = 5
    }
    
    private let viewState: MainScreenRootViewState
    private weak var output: MainScreenRootOutput?
    private let modulesFactory: ModulesFactoring
    private let randomRecipesService: RandomRecipesServicing
    
    private var recipesLoadingTask: Task<Void, Never>?
    
    init(
        viewState: MainScreenRootViewState,
        output: MainScreenRootOutput,
        modulesFactory: ModulesFactoring,
        randomRecipesService: RandomRecipesServicing
    ) {
        self.viewState = viewState
        self.output = output
        self.modulesFactory = modulesFactory
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
    }
    
    private func didTapCarouselCell(text: String) {
        cancelTasks()
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
    
    // MARK: - Random Recipes
    
    private func loadRecipes(type: String) {
        guard recipesLoadingTask.isNil else {
            return
        }
        
        viewState.recipesViewModel.contentState = .skeleton
        
        recipesLoadingTask = Task {
            do {
                let recipes = try await randomRecipesService.loadWithType(
                    type.lowercased(),
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
        output?.openRecipe(id: id)
    }
    
    private func handleSaveRecipeTapped() {
        print("Tapped save recipe")
    }
    
    @MainActor private func updateRecipesList(_ recipes: [RecipeInformation]) {
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
    
    // MARK: - Error Screen
    
    @MainActor private func showErrorScreen() {
        let errorViewModel = ErrorViewModel(
            title: "somethingWentWrong".localized(),
            buttonText: "tryAgain".localized()) { [weak self] in
                self?.loadRecipes(
                    type: self?.viewState.carouselViewModel.cells
                        .first { $0.isSelected }?.text ?? ""
                )
                
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

// MARK: - MainScreenRootInput

extension MainScreenRootViewModel: MainScreenRootInput {
    func bootstrap() {
        setupCarousel()
        loadRecipes(type: viewState.carouselViewModel.cells.first?.text ?? "")
    }
}

// MARK: - MainScreenNavigationViewOutput

extension MainScreenRootViewModel: MainScreenRootViewOutput {}
