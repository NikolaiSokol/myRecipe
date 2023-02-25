//
//  ApiConstants.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

enum ApiConstants {
    static let baseUrl = "https://api.spoonacular.com"
    static let ingredientImageUrl = "https://spoonacular.com/cdn/ingredients_100x100/"
    static let key = "98f636fb183748f9845eb2f65b988383"
    
    enum AvailableMealTypes: String, CaseIterable {
        case breakfast
        case mainCourse = "main course"
        case sideDish = "side dish"
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
}
