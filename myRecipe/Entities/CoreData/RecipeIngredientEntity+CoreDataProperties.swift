//
//  RecipeIngredientEntity+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//
//

import Foundation
import CoreData

extension RecipeIngredientEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeIngredientEntity> {
        NSFetchRequest<RecipeIngredientEntity>(entityName: "RecipeIngredientEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var measures: MeasuresEntity?
    @NSManaged public var recipe: RecipeEntity?
    @NSManaged public var step: RecipeInstructionStepEntity?

}

extension RecipeIngredientEntity: Identifiable {}
