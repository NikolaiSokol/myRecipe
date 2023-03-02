//
//  SearchParameters.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

struct SearchParameters {
    let query: String
    let addRecipeInformation = true
    let offset: Int
    let number: Int
    let sorting: SortingOption
    let filters: AppliedFilters
}
