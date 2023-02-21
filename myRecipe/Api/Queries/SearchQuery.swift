//
//  SearchQuery.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

struct SearchQuery: QueryItemsRepresentable {
    let query: String
    let addRecipeInformation = true
    let offset: Int
    let number: Int
    
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
        
        return items
    }
}
