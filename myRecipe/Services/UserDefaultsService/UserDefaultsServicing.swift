//
//  UserDefaultsServicing.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 28.02.2023.
//

import Foundation
import Combine

protocol UserDefaultsServicing {
    // MARK: - Search history
    
    func addToSearchHistory(text: String)
    func removeItemFromSearchHistory(text: String)
    func clearSearchHistory()
    func listenSearchHistory() -> AnyPublisher<[String], Never>
    
    // MARK: - Intolerances
    
    func saveIntolerances(_ intolerances: [IntoleranceType])
    func getIntolerances() -> [IntoleranceType]
}
