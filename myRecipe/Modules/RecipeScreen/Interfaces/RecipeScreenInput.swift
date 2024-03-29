//
//  RecipeScreenInput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

protocol RecipeScreenInput: AnyObject {
    func configure(inputModel: RecipeScreenInputModel)
}
