//
//  RandomRecipesByTypeOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation

protocol RandomRecipesByTypeOutput: AnyObject {
    func randomRecipesByTypeDidRequest(event: RandomRecipesByTypeEvent)
}
