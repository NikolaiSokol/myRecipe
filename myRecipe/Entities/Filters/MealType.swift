//
//  MealType.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 02.03.2023.
//

import Foundation

enum MealType: String, CaseIterable {
    case `default`
    case breakfast
    case mainCourse
    case sideDish
    case dessert
    case appetizer
    case salad
    case bread
    case soup
    case beverage
    case sauce
    case marinade
    case fingerfood
    case snack
    case drink
}

extension MealType: Localizable {
    // swiftlint:disable:next cyclomatic_complexity
    func localizedString() -> String {
        switch self {
        case .default:
            return String(localized: .select)
            
        case .breakfast:
            return String(localized: .mealTypeBreakfast)
            
        case .mainCourse:
            return String(localized: .mealTypeMainCourse)
            
        case .sideDish:
            return String(localized: .mealTypeSideDish)
            
        case .dessert:
            return String(localized: .mealTypeDessert)
            
        case .appetizer:
            return String(localized: .mealTypeAppetizer)
            
        case .salad:
            return String(localized: .mealTypeSalad)
            
        case .bread:
            return String(localized: .mealTypeBread)
            
        case .soup:
            return String(localized: .mealTypeSoup)
            
        case .beverage:
            return String(localized: .mealTypeBeverage)
            
        case .sauce:
            return String(localized: .mealTypeSauce)
            
        case .marinade:
            return String(localized: .mealTypeMarinade)
            
        case .fingerfood:
            return String(localized: .mealTypeFingerfood)
            
        case .snack:
            return String(localized: .mealTypeSnack)
            
        case .drink:
            return String(localized: .mealTypeDrink)
        }
    }
}
