//
//  ExtendedIngredientsCoreData+CoreDataProperties.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//
//

import Foundation
import CoreData

extension ExtendedIngredientsCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExtendedIngredientsCoreData> {
        NSFetchRequest<ExtendedIngredientsCoreData>(entityName: "ExtendedIngredientsCoreData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var image: String
    @NSManaged public var name: String
    @NSManaged public var measures: MeasuresCoreData
    @NSManaged public var recipe: RecipeCoreData?

}

extension ExtendedIngredientsCoreData: Identifiable {

}
