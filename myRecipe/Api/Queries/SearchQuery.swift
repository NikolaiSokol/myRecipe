//
//  SearchQuery.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

struct SearchQuery: QueryItemsRepresentable {
    let query: String
    let addRecipeInformation: Bool
    let offset: Int
    let number: Int
    let sorting: SortingOption
    let filters: AppliedFilters
    
    func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        
        let queryItem = URLQueryItem(name: "query", value: query)
        items.append(queryItem)
        
        let addRecipeInformationItem = URLQueryItem(name: "addRecipeInformation", value: String(addRecipeInformation))
        items.append(addRecipeInformationItem)
        
        let offsetItem = URLQueryItem(name: "offset", value: String(offset))
        items.append(offsetItem)
        
        let numberItem = URLQueryItem(name: "number", value: String(number))
        items.append(numberItem)
        
        if !sorting.isDefault() {
            let sortItem = URLQueryItem(name: "sort", value: sorting.rawValue)
            items.append(sortItem)
        }
        
        if sorting == .time {
            let sortDirectionItem = URLQueryItem(name: "sortDirection", value: "asc")
            items.append(sortDirectionItem)
        }
        
        if !filters.isDefault() {
            if filters.instructionsRequired {
                let instructionsRequiredItem = URLQueryItem(
                    name: "instructionsRequired",
                    value: String(filters.instructionsRequired)
                )
                items.append(instructionsRequiredItem)
            }
            
            if filters.cuisine != .default {
                let cuisineItem = URLQueryItem(name: "cuisine", value: filters.cuisine.rawValue)
                items.append(cuisineItem)
            }
            
            if filters.diet != .default {
                let dietItem = URLQueryItem(name: "diet", value: filters.diet.rawValue)
                items.append(dietItem)
            }
            
            if filters.meal != .default {
                let mealItem = URLQueryItem(name: "type", value: filters.meal.rawValue)
                items.append(mealItem)
            }
            
            if !filters.intolerances.isEmpty {
                let intolerancesItem = URLQueryItem(
                    name: "intolerances",
                    value: filters.intolerances
                        .map { $0.rawValue }
                        .joined(separator: ",")
                )
                items.append(intolerancesItem)
            }
            
            if !filters.maxCalories.isEmpty {
                let maxCaloriesItem = URLQueryItem(name: "maxCalories", value: filters.maxCalories)
                items.append(maxCaloriesItem)
            }
        }
        
        return items
    }
}
