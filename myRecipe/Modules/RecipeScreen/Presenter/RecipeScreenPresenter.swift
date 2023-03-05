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
    private let persistentService: PersistentServicing
    
    init(
        viewState: RecipeScreenViewState,
        output: RecipeScreenOutput,
        recipeInformationService: RecipeInformationServicing,
        userDefaultsService: UserDefaultsServicing,
        persistentService: PersistentServicing
    ) {
        self.viewState = viewState
        self.output = output
        self.recipeInformationService = recipeInformationService
        self.userDefaultsService = userDefaultsService
        self.persistentService = persistentService
    }
    
    private func checkIsRecipeSaved() {
        do {
            let isSaved = try persistentService.isRecipeSaved(id: viewState.recipe.id)
            
            viewState.updateIsRecipeSaved(to: isSaved)
            
        } catch {
            ErrorLogger.shared.log(error)
        }
    }
    
    private func loadRecipeInfo(id: Int) {
        guard viewState.recipe.nutrients.isEmpty || viewState.recipe.ingredients.isEmpty else {
            updateNutrients()
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
        viewState.recipe.ingredients = recipe.ingredients
        viewState.recipe.nutrients = recipe.nutrients
        
        updateNutrients()
    }
    
    private func updateNutrients() {
        viewState.nutrientBlockViewModel.nutrients = Array(viewState.recipe.nutrients.prefix(LocalConstants.maxNutrientsToShow))
        
        if viewState.recipe.nutrients.count > LocalConstants.maxNutrientsToShow {
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
        checkIsRecipeSaved()
    }
}

// MARK: - RecipeScreenViewOutput

extension RecipeScreenPresenter: RecipeScreenViewOutput {
    func didTapSaveRecipe() {
        Task {
            do {
                try await persistentService.saveRecipe(viewState.recipe) { isSucceeded in
                    DispatchQueue.main.async { [weak self] in
                        self?.viewState.updateIsRecipeSaved(to: isSucceeded)
                        
                        if isSucceeded {
                            self?.viewState.shouldShowSavingPopupSubject.send()
                            self?.output?.recipeScreenDidRequest(event: .persistentChanged)
                        }
                    }
                }
                
            } catch {
                viewState.updateIsRecipeSaved(to: false)
                
                ErrorLogger.shared.log(error)
            }
        }
    }
    
    func didTapDeleteRecipe() {
        do {
            try persistentService.deleteRecipe(id: viewState.recipe.id)
            
            viewState.updateIsRecipeSaved(to: false)
            viewState.shouldShowSavingPopupSubject.send()
            
            output?.recipeScreenDidRequest(event: .persistentChanged)
            
        } catch {
            viewState.updateIsRecipeSaved(to: true)
            
            ErrorLogger.shared.log(error)
        }
    }
}
