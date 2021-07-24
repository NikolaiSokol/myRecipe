//
//  SearchRecipesNetworkManagerProtocol.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import Foundation

protocol SearchRecipesNetworkManagerProtocol {

    typealias AutocompleteCompletion = (Result<[AutocompleteRecipeSearch], Error>) -> Void
    typealias RandomCompletion = (Result<RandomRecipes, Error>) -> Void
    typealias SearchCompletion = (Result<SearchedRecipes, Error>) -> Void

    func loadAutocomplete(text: String, completion: @escaping AutocompleteCompletion)
    func loadRandomRecipes(completion: @escaping RandomCompletion)
    func searchRecipesWith(text: String, offset: Int, number: Int, completion: @escaping SearchCompletion)
    func searchRecipesWith(parameters: RecipesSearchParameters, offset: Int, number: Int, completion: @escaping SearchCompletion)
    
}
