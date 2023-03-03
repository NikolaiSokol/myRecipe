//
//  RecipeScreenViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

final class RecipeScreenViewState: ObservableObject {
    @Published var recipe: Recipe = .empty
    @Published var isShowingNutrition = false
    @Published var measureSystem: MeasureSystem = .us
    
    var didMeasureSummaryHeight = false
    var nutrientBlockViewModel = NutrientsBlockViewModel()
    var nutrients: [Nutrient] = []
}
