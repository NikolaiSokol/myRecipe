//
//  PersistentService.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 05.03.2023.
//

import Foundation
import CoreData

final class PersistentService {
    private enum LocalConstants {
        static let containerName = "myRecipe"
        static let recipeEntityName = "RecipeEntity"
        static let sortingKey = "savingDate"
    }
    
    private let persistentMapper: PersistentMapping
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: LocalConstants.containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                ErrorLogger.shared.log(error)
            }
        }
        return container
    }()
    
    private lazy var viewContext = container.viewContext
    private lazy var backgroundContext = container.newBackgroundContext()
    
    init(persistentMapper: PersistentMapping) {
        self.persistentMapper = persistentMapper

    }
    
    private func save(context: NSManagedObjectContext) throws {
        guard context.hasChanges else {
            return
        }
        
        try context.save()
    }
    
    private func getRequestFor(id: Int) -> NSFetchRequest<RecipeEntity> {
        let request = NSFetchRequest<RecipeEntity>(entityName: LocalConstants.recipeEntityName)
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        
        return request
    }
}

extension PersistentService: PersistentServicing {
    func saveRecipe(_ recipe: Recipe, isSucceeded: @escaping (Bool) -> Void) async throws {
        guard try !isRecipeSaved(id: recipe.id) else {
            isSucceeded(false)
            return
        }
        
        let context = backgroundContext
        
        try await context.perform { [weak self] in
            self?.persistentMapper.map(recipe, context: context)
            
            try self?.save(context: context)
            
            isSucceeded(true)
        }
    }
    
    func getRecipes() throws -> [Recipe] {
        let request = NSFetchRequest<RecipeEntity>(entityName: LocalConstants.recipeEntityName)
        request.sortDescriptors = [.init(key: LocalConstants.sortingKey, ascending: false)]
        
        let entities = try viewContext.fetch(request)
        
        return persistentMapper.map(entities: entities)
    }
    
    func deleteRecipe(id: Int) throws {
        let request = getRequestFor(id: id)
        let context = backgroundContext
        
        let entities = try context.fetch(request)
        
        entities.forEach {
            context.delete($0)
        }
        
        try save(context: context)
    }
    
    func isRecipeSaved(id: Int) throws -> Bool {
        let request = getRequestFor(id: id)
        
        return try !viewContext.count(for: request).isZero
    }
}
