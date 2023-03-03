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
    
    private func loadNutrients(id: Int) {
        Task {
            do {
                let nutrients = try await recipeInformationService.loadNutrients(id: id)
                
                await updateNutrients(nutrients)
                
            } catch {
                ErrorLogger.shared.log(error)
            }
        }
    }
    
    @MainActor private func updateNutrients(_ nutrients: [Nutrient]) {
        viewState.nutrients = nutrients
        
        viewState.nutrientBlockViewModel.nutrients = Array(nutrients.prefix(LocalConstants.maxNutrientsToShow))
        
        if nutrients.count > LocalConstants.maxNutrientsToShow {
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
        loadNutrients(id: inputModel.recipe.id)
    }
}

// MARK: - RecipeScreenViewOutput

extension RecipeScreenPresenter: RecipeScreenViewOutput {}
