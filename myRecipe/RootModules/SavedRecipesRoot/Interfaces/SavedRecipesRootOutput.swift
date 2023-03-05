//
//  SavedRecipesRootOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//  
//

import Foundation

protocol SavedRecipesRootOutput: AnyObject {
    func savedRecipesRootDidRequest(event: SavedRecipesRootEvent)
}
