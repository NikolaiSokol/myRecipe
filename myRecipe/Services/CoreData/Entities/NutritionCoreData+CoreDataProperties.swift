//
//  NutritionCoreData+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//
//

import Foundation
import CoreData

extension NutritionCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NutritionCoreData> {
        NSFetchRequest<NutritionCoreData>(entityName: "NutritionCoreData")
    }

    @NSManaged public var caloricBreakdown: CaloricBreakdownCoreData
    @NSManaged public var nutrients: NSSet?
    @NSManaged public var recipe: RecipeCoreData?
    @NSManaged public var weightPerServing: WeightPerServingCoreData

}

// MARK: Generated accessors for nutrients
extension NutritionCoreData {

    @objc(addNutrientsObject:)
    @NSManaged public func addToNutrients(_ value: NutrientsCoreData)

    @objc(removeNutrientsObject:)
    @NSManaged public func removeFromNutrients(_ value: NutrientsCoreData)

    @objc(addNutrients:)
    @NSManaged public func addToNutrients(_ values: NSSet)

    @objc(removeNutrients:)
    @NSManaged public func removeFromNutrients(_ values: NSSet)

}

extension NutritionCoreData: Identifiable {

}
