//
//  PersistentMapping.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//

import Foundation
import CoreData

protocol PersistentMapping {
    func map(_ recipe: Recipe, context: NSManagedObjectContext)
    func map(entities: [RecipeEntity]) -> [Recipe]
}
