//
//  WeightPerServingCoreData+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//
//

import Foundation
import CoreData

extension WeightPerServingCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeightPerServingCoreData> {
        NSFetchRequest<WeightPerServingCoreData>(entityName: "WeightPerServingCoreData")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var unit: String
    @NSManaged public var nutrition: NutritionCoreData?

}

extension WeightPerServingCoreData: Identifiable {

}
