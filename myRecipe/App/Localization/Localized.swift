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
    
    // MARK: - Filters
    
    case filters
    case select
    case clearAll
    case instructionsRequired
    case maximumCalories
    case amount
    case apply
    
    case cuisineAfrican
    case cuisineAmerican
    case cuisineBritish
    case cuisineCajun
    case cuisineCaribbean
    case cuisineChinese
    case cuisineEasternEuropean
    case cuisineEuropean
    case cuisineFrench
    case cuisineGerman
    case cuisineGreek
    case cuisineIndian
    case cuisineIrish
    case cuisineItalian
    case cuisineJapanese
    case cuisineJewish
    case cuisineKorean
    case cuisineLatinAmerican
    case cuisineMediterranean
    case cuisineMexican
    case cuisineMiddleEastern
    case cuisineNordic
    case cuisineSouthern
    case cuisineSpanish
    case cuisineThai
    case cuisineVietnamese
    
    case diet
    case dietGlutenFree
    case dietKetogenic
    case dietVegetarian
    case dietLactoVegetarian
    case dietOvoVegetarian
    case dietVegan
    case dietPescetarian
    case dietPaleo
    case dietPrimal
    case dietLowFODMAP
    case dietWhole30
    
    case mealType
    case mealTypeBreakfast
    case mealTypeMainCourse
    case mealTypeSideDish
    case mealTypeDessert
    case mealTypeAppetizer
    case mealTypeSalad
    case mealTypeBread
    case mealTypeSoup
    case mealTypeBeverage
    case mealTypeSauce
    case mealTypeMarinade
    case mealTypeFingerfood
    case mealTypeSnack
    case mealTypeDrink
    
    case intolerances
    case intoleranceDairy
    case intoleranceEgg
    case intoleranceGluten
    case intoleranceGrain
    case intolerancePeanut
    case intoleranceSeafood
    case intoleranceSesame
    case intoleranceShellfish
    case intoleranceSoy
    case intoleranceSulfite
    case intoleranceTreeNut
    case intoleranceWheat
    
    // MARK: - Error
    
    case somethingWentWrong
    case tryAgain
    case notFound
    case weAreSorry
}
