//
//  RecipeInstructionStepEntity+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//
//

import Foundation
import CoreData

extension RecipeInstructionStepEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeInstructionStepEntity> {
        NSFetchRequest<RecipeInstructionStepEntity>(entityName: "RecipeInstructionStepEntity")
    }

    @NSManaged public var number: Int64
    @NSManaged public var text: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var recipe: RecipeEntity?
    @NSManaged public var steps: RecipeInstructionStepEntity?

}

// MARK: Generated accessors for ingredients
extension RecipeInstructionStepEntity {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: RecipeIngredientEntity)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: RecipeIngredientEntity)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension RecipeInstructionStepEntity: Identifiable {}
