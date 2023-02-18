//
//  ModulesFactory.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class ModulesFactory: ModulesFactoring {
    func makeMainScreen(output: MainScreenOutput) -> MainScreenModule {
        MainScreenConfigurator().configure(output: output)
    }
    
    func makeSettingsScreen(output: SettingsScreenOutput) -> SettingsScreenModule {
        SettingsScreenConfigurator().configure(output: output)
    }
}
