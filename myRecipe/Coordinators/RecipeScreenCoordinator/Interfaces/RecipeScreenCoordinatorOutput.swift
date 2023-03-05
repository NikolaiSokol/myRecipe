//
//  RecipeScreenCoordinatorOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

protocol RecipeScreenCoordinatorOutput: AnyObject {
    func recipeScreenCoordinatorDidRequest(event: RecipeScreenCoordinatorEvent)
}
