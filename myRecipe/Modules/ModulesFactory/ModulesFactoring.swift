//
//  ModulesFactoring.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

typealias NavigableModule<T> = (view: NavigableView, input: T)

protocol ModulesFactoring {
    func makeMainScreen(output: MainScreenOutput) -> MainScreenModule
    func makeSettingsScreen(output: SettingsScreenOutput) -> SettingsScreenModule
}
