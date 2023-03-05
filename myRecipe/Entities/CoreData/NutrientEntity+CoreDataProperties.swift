//
//  NutrientEntity+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//
//

import Foundation
import CoreData

extension NutrientEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NutrientEntity> {
        NSFetchRequest<NutrientEntity>(entityName: "NutrientEntity")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var amount: String?
    @NSManaged public var unit: String?
    @NSManaged public var percentOfDailyNeeds: Double
    @NSManaged public var recipe: RecipeEntity?

}

extension NutrientEntity: Identifiable {}
