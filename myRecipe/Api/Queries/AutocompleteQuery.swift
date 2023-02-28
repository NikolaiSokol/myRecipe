//
//  AutocompleteQuery.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 28.02.2023.
//

import Foundation

struct AutocompleteQuery: QueryItemsRepresentable {
    let query: String
    let number: Int
    
    func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        
        let queryItem = URLQueryItem(name: "query", value: query)
        items.append(queryItem)
        
        let numberItem = URLQueryItem(name: "number", value: String(number))
        items.append(numberItem)
        
        return items
    }
}
