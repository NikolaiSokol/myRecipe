//
//  Localized.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 25.02.2023.
//

import Foundation

enum Localized: String {
    // MARK: - Main
    
    case hello
    case whatYouWantToCook
    
    // MARK: - Recipe
    
    case min
    case expand
    case collapse
    case ingredients
    case instructions
    case cookTime
    case serves
    case serving
    case cuisine
    case perfectFor
    case viewMore
    case nutritionDataIsPerServing
    case ofDailyNeeds
    
    // MARK: - Search
    
    case searchRecipes
    case cancel
    case sort
    case previousSearches
    case defaultSorting
    case popularity
    case calories
    case filters
    
    // MARK: - Error
    
    case somethingWentWrong
    case tryAgain
    case notFound
    case weAreSorry
}
