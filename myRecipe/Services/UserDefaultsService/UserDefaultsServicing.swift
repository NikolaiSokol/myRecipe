//
//  UserDefaultsServicing.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 28.02.2023.
//

import Foundation
import Combine

protocol UserDefaultsServicing {
    func addToSearchHistory(text: String)
    func removeItemFromSearchHistory(text: String)
    func clearSearchHistory()
    func listenSearchHistory() -> AnyPublisher<[String], Never>
}
