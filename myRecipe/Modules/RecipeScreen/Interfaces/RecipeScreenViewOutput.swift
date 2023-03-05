//
//  RecipeScreenViewOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

protocol RecipeScreenViewOutput: AnyObject {
    func didTapSaveRecipe()
    func didTapDeleteRecipe()
}
