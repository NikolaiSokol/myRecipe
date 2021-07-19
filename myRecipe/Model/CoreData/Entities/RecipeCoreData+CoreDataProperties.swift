//
//  RecipeCoreData+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//
//

import Foundation
import CoreData

extension RecipeCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeCoreData> {
        NSFetchRequest<RecipeCoreData>(entityName: "RecipeCoreData")
    }

    @NSManaged public var dishTypes: [String]
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var instructions: String
    @NSManaged public var readyInMinutes: Int64
    @NSManaged public var savedDate: Date?
    @NSManaged public var servings: Int64
    @NSManaged public var sourceName: String
    @NSManaged public var sourceUrl: String
    @NSManaged public var title: String
    @NSManaged public var extendedIngredients: NSSet?
    @NSManaged public var nutrition: NutritionCoreData

}

// MARK: Generated accessors for extendedIngredients
extension RecipeCoreData {

    @objc(addExtendedIngredientsObject:)
    @NSManaged public func addToExtendedIngredients(_ value: ExtendedIngredientsCoreData)

    @objc(removeExtendedIngredientsObject:)
    @NSManaged public func removeFromExtendedIngredients(_ value: ExtendedIngredientsCoreData)

    @objc(addExtendedIngredients:)
    @NSManaged public func addToExtendedIngredients(_ values: NSSet)

    @objc(removeExtendedIngredients:)
    @NSManaged public func removeFromExtendedIngredients(_ values: NSSet)

}

extension RecipeCoreData: Identifiable {

}
