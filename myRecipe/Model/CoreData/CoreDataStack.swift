//
//  CoreDataStack.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.07.2021.
//

import Foundation
import CoreData

final class CoreDataStack {

    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "myRecipe")
        container.loadPersistentStores { _, error in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        return container
    }()
    
    private lazy var viewContext = container.viewContext
    lazy var backgroundContext = container.newBackgroundContext()
    
    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    func isRecipeSaved(id: Int) -> Bool {
        let request = NSFetchRequest<RecipeCoreData>(entityName: "RecipeCoreData")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            if try backgroundContext.count(for: request) > 0 {
                return true
            } else {
                return false
            }
        } catch {
            assertionFailure(error.localizedDescription)
            return false
        }
    }
    
    func deleteRecipe(id: Int) {
        let request = NSFetchRequest<RecipeCoreData>(entityName: "RecipeCoreData")
        request.predicate = NSPredicate(format: "id == %d", id)
        
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            do {
                let recipes = try request.execute()
                recipes.forEach {
                    self.backgroundContext.delete($0)
                }
                self.saveContext(context: self.backgroundContext)
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }
}
