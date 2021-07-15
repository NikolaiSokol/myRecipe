//
//  SavedRecipesViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//

import UIKit
import CoreData

final class SavedRecipesViewModel {
    
    private let imageLoader: ImageLoadingManager
    private let coreDataStack: CoreDataStack
    
    var errorOccured: (() -> Void)?
    
    init(imageLoader: ImageLoadingManager, coreDataStack: CoreDataStack) {
        self.imageLoader = imageLoader
        self.coreDataStack = coreDataStack
    }
    
    func getContext() -> NSManagedObjectContext {
        coreDataStack.backgroundContext
    }
    
    // MARK: - Image
    
    func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
        imageLoader.loadImage(imageUrl: url) { result in
            DispatchQueue.main.async {  [weak self] in
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
