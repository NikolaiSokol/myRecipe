//
//  InFridgeNetworkManagerProtocol.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import Foundation

protocol InFridgeNetworkManagerProtocol {

    typealias AutocompleteCompletion = (Result<[AutocompleteIngredient], Error>) -> Void
    typealias RecipesCompletion = (Result<[SearchedRecipe], Error>) -> Void

    func loadAutocomplete(text: String, completion: @escaping AutocompleteCompletion)
    func loadRecipes(ingredients: String, completion: @escaping RecipesCompletion)
    
}
