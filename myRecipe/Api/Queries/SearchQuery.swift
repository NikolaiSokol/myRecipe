//
//  SearchQuery.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

struct SearchQuery: QueryItemsRepresentable {
    let params: SearchParameters
    
    func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        
        let queryItem = URLQueryItem(name: "query", value: params.query)
        items.append(queryItem)
        
        let addRecipeInformationItem = URLQueryItem(name: "addRecipeInformation", value: String(params.addRecipeInformation))
        items.append(addRecipeInformationItem)
        
        let offsetItem = URLQueryItem(name: "offset", value: String(params.offset))
        items.append(offsetItem)
        
        let numberItem = URLQueryItem(name: "number", value: String(params.number))
        items.append(numberItem)
        
        return items
    }
}
