//
//  SavedRecipesRootInput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//  
//

import Foundation

protocol SavedRecipesRootInput: AnyObject {
    func bootstrap()
    func updateRecipes()
}
