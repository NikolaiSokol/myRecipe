//
//  CaloricBreakdownCoreData+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//
//

import Foundation
import CoreData

extension CaloricBreakdownCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CaloricBreakdownCoreData> {
        NSFetchRequest<CaloricBreakdownCoreData>(entityName: "CaloricBreakdownCoreData")
    }

    @NSManaged public var percentCarbs: Float
    @NSManaged public var percentFat: Float
    @NSManaged public var percentProtein: Float
    @NSManaged public var nutrition: NutritionCoreData?

}

extension CaloricBreakdownCoreData: Identifiable {

}
