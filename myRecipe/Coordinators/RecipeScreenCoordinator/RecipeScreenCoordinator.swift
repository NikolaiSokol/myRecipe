//
//  RecipeScreenCoordinator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

final class RecipeScreenCoordinator {
    private weak var output: RecipeScreenCoordinatorOutput?
    private let modulesFactory: ModulesFactoring
    private let router: Routable
    
    private var recipeScreenInput: RecipeScreenInput?
    
    init(
        output: RecipeScreenCoordinatorOutput?,
        modulesFactory: ModulesFactoring,
        router: Routable
    ) {
        self.output = output
        self.modulesFactory = modulesFactory
        self.router = router
    }
    
    private func showRecipeScreen(inputModel: RecipeScreenInputModel) {
        let unit = modulesFactory.makeRecipeScreen(output: self)
        
        recipeScreenInput = unit.input
        recipeScreenInput?.configure(inputModel: inputModel)
        
        router.present(unit.view)
    }
}

extension RecipeScreenCoordinator: Coordinator {
    func start(with option: CoordinatorOption?) {
        guard let model = option as? RecipeScreenInputModel else {
            return
        }
        
        showRecipeScreen(inputModel: model)
    }
}

// MARK: - RecipeScreenCoordinatorInput

extension RecipeScreenCoordinator: RecipeScreenCoordinatorInput {}

// MARK: - RecipeScreenOutput

extension RecipeScreenCoordinator: RecipeScreenOutput {
    func recipeScreenDidRequest(event: RecipeScreenEvent) {
        switch event {
        case .persistentChanged:
            output?.recipeScreenCoordinatorDidRequest(event: .persistentChanged)
        }
    }
}
