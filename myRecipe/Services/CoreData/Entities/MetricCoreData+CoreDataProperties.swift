//
//  MetricCoreData+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//
//

import Foundation
import CoreData

extension MetricCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MetricCoreData> {
        NSFetchRequest<MetricCoreData>(entityName: "MetricCoreData")
    }

    @NSManaged public var amount: Float
    @NSManaged public var unitLong: String
    @NSManaged public var measuresMetric: MeasuresCoreData?
    @NSManaged public var measuresUs: MeasuresCoreData?

}

extension MetricCoreData: Identifiable {

}
