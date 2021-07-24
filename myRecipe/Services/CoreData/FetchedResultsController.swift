//
//  FetchedResultsController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 19.07.2021.
//

import Foundation
import CoreData

enum FetchedResultsController {
    static func getFetchedResultsController(delegate: NSFetchedResultsControllerDelegate, context: NSManagedObjectContext) -> NSFetchedResultsController<RecipeCoreData> {
        let request = NSFetchRequest<RecipeCoreData>(entityName: "RecipeCoreData")
        request.sortDescriptors = [.init(key: "savedDate", ascending: false)]
        
        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        frc.delegate = delegate
        
        return frc
    }
}
