//
//  MeasuresEntity+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//
//

import Foundation
import CoreData

extension MeasuresEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasuresEntity> {
        NSFetchRequest<MeasuresEntity>(entityName: "MeasuresEntity")
    }

    @NSManaged public var us: MeasureEntity?
    @NSManaged public var metric: MeasureEntity?
    @NSManaged public var ingredient: RecipeIngredientEntity?

}

extension MeasuresEntity: Identifiable {}
