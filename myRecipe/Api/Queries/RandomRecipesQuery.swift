//
//  RandomRecipesQuery.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

struct RandomRecipesQuery: QueryItemsRepresentable {
    let tags: String
    let number: Int
    
    func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        
        let tagsItem = URLQueryItem(name: "tags", value: tags)
        items.append(tagsItem)
        
        let numberItem = URLQueryItem(name: "number", value: String(number))
        items.append(numberItem)
        
        return items
    }
}
