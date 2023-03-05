//
//  RecipeScreenOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

protocol RecipeScreenOutput: AnyObject {
    func recipeScreenDidRequest(event: RecipeScreenEvent)
}
