//
//  RecipeInformationQuery.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

struct RecipeInformationQuery: QueryItemsRepresentable {
    let includeNutrition: Bool
    
    func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        
        let includeNutritionItem = URLQueryItem(name: "includeNutrition", value: String(includeNutrition))
        items.append(includeNutritionItem)
        
        return items
    }
}
