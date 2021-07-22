//
//  SavedRecipesViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//

import UIKit
import CoreData

final class SavedRecipesViewModel: NSObject, NSFetchedResultsControllerDelegate {
    
    private let imageLoader: ImageLoadingManager
    private let coreDataStack: CoreDataStack
    
    private(set) lazy var fetchedResultsController: NSFetchedResultsController<RecipeCoreData> = {
        FetchedResultsController.getFetchedResultsController(delegate: self, context: coreDataStack.backgroundContext)
    }()
    
    var searchedText = "" {
        didSet {
            if searchedText.isEmpty {
                fetchedResultsController.fetchRequest.predicate = nil
                performFetch()
            } else {
                fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "title CONTAINS %@", searchedText)
                performFetch()
            }
        }
    }
    
    var recipesChanged: (() -> Void)?
    var errorOccured: (() -> Void)?
    
    init(imageLoader: ImageLoadingManager, coreDataStack: CoreDataStack) {
        self.imageLoader = imageLoader
        self.coreDataStack = coreDataStack
    }
    
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            errorOccured?()
        }
        
        recipesChanged?()
    }
    
    func deleteRecipeFromCoreData(id: Int) {
        coreDataStack.deleteRecipe(id: id)
    }
    
    // MARK: - Fetched Results Controller Delegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async { [weak self] in
            self?.recipesChanged?()
        }
    }
    
    // MARK: - Image
    
    func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
        imageLoader.loadImage(imageUrl: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loadedImage):
                    completion(loadedImage)
                case .failure:
                    print("Error")
                    self?.errorOccured?()
                }
            }
        }
    }
}
