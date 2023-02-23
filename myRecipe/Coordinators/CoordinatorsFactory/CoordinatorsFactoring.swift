//
//  CoordinatorsFactoring.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

typealias RootCoordinatorModule<T> = (view: AnyView, input: T)
typealias ConcreteCoordinator<T> = (coordinator: Coordinator, input: T)

protocol CoordinatorsFactoring {
    func makeTabBarCoordinator() -> RootCoordinator
    
    func makeMainScreenRootCoordinator(
        output: MainScreenCoordinatorOutput
    ) -> RootCoordinatorModule<MainScreenCoordinatorInput>
    
    func makeSettingsScreenRootCoordinator(
        output: SettingsScreenCoordinatorOutput
    ) -> RootCoordinatorModule<SettingsScreenCoordinatorInput>
    
    func makeRecipeScreenCoordinator(
        output: RecipeScreenCoordinatorOutput,
        router: Routable
    ) -> ConcreteCoordinator<RecipeScreenCoordinatorInput>
}
