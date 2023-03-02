//
//  UserDefaultsService.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 28.02.2023.
//

import Foundation
import Combine

private enum Keys: String {
    case historySearches
    case intolerances
}

final class UserDefaultsService {
    private enum LocalConstants {
        static let maxHistorySearchesToKeep = 5
    }
    
    private let defaults = UserDefaults.standard
    
    private func getSearchHistory() -> [String] {
        defaults.stringArray(forKey: Keys.historySearches.rawValue) ?? []
    }
}

extension UserDefaultsService: UserDefaultsServicing {
    // MARK: - Search history
    
    func addToSearchHistory(text: String) {
        guard !text.isEmpty else {
            return
        }
        
        var historySearches = getSearchHistory()
        
        if !historySearches.contains(where: { $0.lowercased() == text.lowercased() }) {
            historySearches.insert(text.capitalizingFirstLetter(), at: 0)

            if historySearches.count > LocalConstants.maxHistorySearchesToKeep {
                historySearches = Array(historySearches.prefix(LocalConstants.maxHistorySearchesToKeep))
            }

            defaults.set(historySearches, forKey: Keys.historySearches.rawValue)
        }
    }
    
    func removeItemFromSearchHistory(text: String) {
        var historySearches = getSearchHistory()
        
        if let index = historySearches.firstIndex(where: { $0.lowercased() == text.lowercased() }) {
            historySearches.remove(at: index)
            
            defaults.set(historySearches, forKey: Keys.historySearches.rawValue)
        }
    }
    
    func clearSearchHistory() {
        defaults.set([String](), forKey: Keys.historySearches.rawValue)
    }
    
    func listenSearchHistory() -> AnyPublisher<[String], Never> {
        defaults.publisher(for: \.historySearches).eraseToAnyPublisher()
    }
    
    // MARK: - Intolerances
    
    func saveIntolerances(_ intolerances: [IntoleranceType]) {
        guard let data = try? JSONEncoder().encode(intolerances) else {
            return
        }
        
        defaults.set(data, forKey: Keys.intolerances.rawValue)
    }
    
    func getIntolerances() -> [IntoleranceType] {
        guard let data = defaults.data(forKey: Keys.intolerances.rawValue),
              let intolerances = try? JSONDecoder().decode([IntoleranceType].self, from: data)
        else {
            return []
        }
        
        return intolerances
    }
}

private extension UserDefaults {
    @objc dynamic var historySearches: [String] {
        object(forKey: Keys.historySearches.rawValue) as? [String] ?? []
    }
}
