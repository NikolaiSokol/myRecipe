//
//  MeasureEntity+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//
//

import Foundation
import CoreData

extension MeasureEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasureEntity> {
        NSFetchRequest<MeasureEntity>(entityName: "MeasureEntity")
    }

    @NSManaged public var amount: Double
    @NSManaged public var unitShort: String?
    @NSManaged public var measuresUs: MeasuresEntity?
    @NSManaged public var measuresMetric: MeasuresEntity?

}

extension MeasureEntity: Identifiable {}
