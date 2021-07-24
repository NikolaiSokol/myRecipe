//
//  NutrientsCoreData+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//
//

import Foundation
import CoreData

extension NutrientsCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NutrientsCoreData> {
        NSFetchRequest<NutrientsCoreData>(entityName: "NutrientsCoreData")
    }

    @NSManaged public var amount: Float
    @NSManaged public var name: String
    @NSManaged public var percentOfDailyNeeds: Float
    @NSManaged public var unit: String
    @NSManaged public var nutrition: NutritionCoreData?

}

extension NutrientsCoreData: Identifiable {

}
