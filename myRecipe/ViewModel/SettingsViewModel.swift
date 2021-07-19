//
//  SettingsViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 19.07.2021.
//

import Foundation

final class SettingsViewModel {
    
    private let userDefaults = UserDefaults.standard
    
    let intolerances = ChoosingSearchParameters.intolerances
    
    func getUserIntolerances() -> String? {
        userDefaults.string(forKey: "Intolerances")
    }
    
    func getUserMeasureSystem() -> MeasureSystem {
        if let measureSystem = userDefaults.string(forKey: "MeasureSystem") {
            if measureSystem == "Metric" {
                return .metric
            } else {
                return .US
            }
        }
        return .metric
    }
    
    func setUserIntolerances(_ chosenIntolerances: String) {
        userDefaults.set(chosenIntolerances, forKey: "Intolerances")
    }
    
    func setUserMeasureSystem(_ chosenSystem: MeasureSystem) {
        userDefaults.set(chosenSystem.rawValue, forKey: "MeasureSystem")
    }
}
