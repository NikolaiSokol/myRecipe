//
//  MeasuresCoreData+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//
//

import Foundation
import CoreData

extension MeasuresCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasuresCoreData> {
        NSFetchRequest<MeasuresCoreData>(entityName: "MeasuresCoreData")
    }

    @NSManaged public var extendedIngredients: ExtendedIngredientsCoreData
    @NSManaged public var metric: MetricCoreData
    @NSManaged public var us: MetricCoreData

}

extension MeasuresCoreData: Identifiable {

}
