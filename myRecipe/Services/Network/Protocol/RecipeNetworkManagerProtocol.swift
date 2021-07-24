//
//  RecipeNetworkManagerProtocol.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import Foundation

protocol RecipeNetworkManagerProtocol {

    typealias RecipeCompletion = (Result<Recipe, Error>) -> Void
    typealias SimilarRecipesCompletion = (Result<[SearchedRecipe], Error>) -> Void

    func loadRecipe(id: Int, completion: @escaping RecipeCompletion)
    func loadSimilarRecipes(id: Int, completion: @escaping SimilarRecipesCompletion)
}
