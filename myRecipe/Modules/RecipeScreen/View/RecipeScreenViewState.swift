//
//  RecipeScreenViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation
import Combine

final class RecipeScreenViewState: ObservableObject {
    @Published var recipe: Recipe = .empty
    @Published var isShowingNutrition = false
    @Published var measureSystem: MeasureSystem = .us
    @Published var isRecipeSaved = false
    
    var didMeasureSummaryHeight = false
    var nutrientBlockViewModel = NutrientsBlockViewModel()
    
    let shouldShowSavingPopupSubject = PassthroughSubject<Void, Never>()
    
    func updateIsRecipeSaved(to newValue: Bool) {
        if isRecipeSaved != newValue {
            isRecipeSaved = newValue
        }
    }
}
