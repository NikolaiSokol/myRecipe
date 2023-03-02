//
//  FiltersViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import Foundation
import Combine

final class FiltersViewModel: ObservableObject {
    @Published var isInstructionsRequired = false
    @Published var chosenCuisine: CuisineType = .default
    @Published var chosenDiet: DietType = .default
    @Published var chosenMeal: MealType = .default
    @Published var chosenIntolerances: Set<IntoleranceType> = []
    @Published var maxCalories = ""
    
    var initialFilters = AppliedFilters.default
    var cuisines: [CuisineType] = []
    var diets: [DietType] = []
    var meals: [MealType] = []
    var intolerances: [IntoleranceType] = []
    
    var applyButtonHandler: ((AppliedFilters) -> Void)?
    
    func didTapClearAll() {
        isInstructionsRequired = false
        chosenCuisine = .default
        chosenDiet = .default
        chosenMeal = .default
        chosenIntolerances.removeAll()
        maxCalories.removeAll()
    }
    
    func isShowingApplyButton() -> Bool {
        initialFilters.instructionsRequired != isInstructionsRequired ||
        initialFilters.cuisine != chosenCuisine ||
        initialFilters.diet != chosenDiet ||
        initialFilters.meal != chosenMeal ||
        Set(initialFilters.intolerances) != chosenIntolerances ||
        maxCalories != initialFilters.maxCalories
    }
    
    func isClearAllButtonDisabled() -> Bool {
        isInstructionsRequired == false &&
        chosenCuisine == .default &&
        chosenDiet == .default &&
        chosenMeal == .default &&
        chosenIntolerances.isEmpty &&
        maxCalories.isEmpty
    }
    
    func didTapApplyButton() {
        let filters = AppliedFilters(
            instructionsRequired: isInstructionsRequired,
            cuisine: chosenCuisine,
            diet: chosenDiet,
            meal: chosenMeal,
            intolerances: chosenIntolerances.sorted(by: <),
            maxCalories: maxCalories
        )
        
        applyButtonHandler?(filters)
    }
}
