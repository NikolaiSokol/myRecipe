//
//  PersistentServicing.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//

import Foundation

protocol PersistentServicing {
    func saveRecipe(_ recipe: Recipe, isSucceeded: @escaping (Bool) -> Void) async throws
    func getRecipes() throws -> [Recipe]
    func deleteRecipe(id: Int) throws
    func isRecipeSaved(id: Int) throws -> Bool
}
