//
//  ModulesFactoring.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

typealias NavigableModule<T> = (view: NavigableView, input: T)

protocol ModulesFactoring {
    // MARK: - Navigable
    
    func makeRecipeScreen(output: RecipeScreenOutput) -> NavigableModule<RecipeScreenInput>
    func makeSearchScreen(output: SearchScreenOutput) -> NavigableModule<SearchScreenInput>
    
    // MARK: - Submodules
    
    func makeSettingsScreen(output: SettingsScreenOutput) -> SettingsScreenModule
    func makeSearchBox(output: SearchBoxOutput) -> SearchBoxModule
    func makeRandomRecipesByType(output: RandomRecipesByTypeOutput) -> RandomRecipesByTypeModule
}
