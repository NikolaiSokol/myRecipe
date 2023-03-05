//
//  RecipeEntity+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//
//

import Foundation
import CoreData

extension RecipeEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var readyInMinutes: String?
    @NSManaged public var servings: String?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var savingDate: Date?
    @NSManaged public var cuisines: [String]?
    @NSManaged public var dishTypes: [String]?
    @NSManaged public var steps: NSSet?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var nutrients: NSSet?

}

// MARK: Generated accessors for steps
extension RecipeEntity {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: RecipeInstructionStepEntity)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: RecipeInstructionStepEntity)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}

// MARK: Generated accessors for ingredients
extension RecipeEntity {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: RecipeIngredientEntity)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: RecipeIngredientEntity)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

// MARK: Generated accessors for nutrients
extension RecipeEntity {

    @objc(addNutrientsObject:)
    @NSManaged public func addToNutrients(_ value: NutrientEntity)

    @objc(removeNutrientsObject:)
    @NSManaged public func removeFromNutrients(_ value: NutrientEntity)

    @objc(addNutrients:)
    @NSManaged public func addToNutrients(_ values: NSSet)

    @objc(removeNutrients:)
    @NSManaged public func removeFromNutrients(_ values: NSSet)

}

extension RecipeEntity: Identifiable {}
