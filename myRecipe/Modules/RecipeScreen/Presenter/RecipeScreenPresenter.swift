//
//  RecipeScreenPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

final class RecipeScreenPresenter {
    private enum LocalConstants {
        static let maxNutrientsToShow = 3
    }
    
    private let viewState: RecipeScreenViewState
    private weak var output: RecipeScreenOutput?
    private let recipeInformationService: RecipeInformationServicing
    private let userDefaultsService: UserDefaultsServicing
    
    init(
        viewState: RecipeScreenViewState,
        output: RecipeScreenOutput,
        recipeInformationService: RecipeInformationServicing,
        userDefaultsService: UserDefaultsServicing
    ) {
        self.viewState = viewState
        self.output = output
        self.recipeInformationService = recipeInformationService
        self.userDefaultsService = userDefaultsService
    }
    
    private func loadRecipeInfo(id: Int) {
        guard viewState.recipe.nutrients.isEmpty || viewState.recipe.ingredients.isEmpty else {
            return
        }
        
        Task {
            do {
                let recipe = try await recipeInformationService.loadRecipeInfo(id: id)
                
                await updateRecipe(recipe)
                
            } catch {
                ErrorLogger.shared.log(error)
            }
        }
    }
    
    @MainActor private func updateRecipe(_ recipe: Recipe) {
        viewState.recipe = recipe
        
        viewState.nutrientBlockViewModel.nutrients = Array(recipe.nutrients.prefix(LocalConstants.maxNutrientsToShow))
        
        if recipe.nutrients.count > LocalConstants.maxNutrientsToShow {
            viewState.nutrientBlockViewModel.viewMoreTapHandler = { [weak self] in
                self?.viewState.isShowingNutrition = true
            }
        }
        
        viewState.nutrientBlockViewModel.contentState = .content
    }
}

// MARK: - RecipeScreenInput

extension RecipeScreenPresenter: RecipeScreenInput {
    func configure(inputModel: RecipeScreenInputModel) {
        viewState.measureSystem = userDefaultsService.getMeasureSystem()
        
        viewState.recipe = inputModel.recipe
        loadRecipeInfo(id: inputModel.recipe.id)
    }
}

// MARK: - RecipeScreenViewOutput

extension RecipeScreenPresenter: RecipeScreenViewOutput {}
