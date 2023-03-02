//
//  AppliedFilters.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import Foundation

struct AppliedFilters: Equatable {
    let instructionsRequired: Bool
    let cuisine: CuisineType
    let diet: DietType
    let meal: MealType
    var intolerances: [IntoleranceType]
    let maxCalories: String
    
    static var `default`: AppliedFilters {
        AppliedFilters(
            instructionsRequired: false,
            cuisine: .default,
            diet: .default,
            meal: .default,
            intolerances: [],
            maxCalories: ""
        )
    }
    
    func isDefault() -> Bool {
        instructionsRequired == false &&
        cuisine == .default &&
        diet == .default &&
        meal == .default &&
        intolerances.isEmpty &&
        maxCalories.isEmpty
    }
}
