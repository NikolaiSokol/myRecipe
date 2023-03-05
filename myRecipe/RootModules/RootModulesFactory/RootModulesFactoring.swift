//
//  RootModulesFactoring.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

typealias RootModule<T> = (view: AnyView, input: T)

protocol RootModulesFactoring {
    func makeTabBar(output: TabBarOutput) -> RootModule<TabBarInput>
    
    func makeMainScreenRoot(
        output: MainScreenRootOutput,
        router: Router
    ) -> RootModule<MainScreenRootInput>
    
    func makeSavedRecipesScreenRoot(
        output: SavedRecipesRootOutput,
        router: Router
    ) -> RootModule<SavedRecipesRootInput>
    
    func makeSettingsScreenRoot(
        output: SettingsScreenRootOutput,
        router: Router
    ) -> RootModule<SettingsScreenRootInput>
}
