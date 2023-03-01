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
        
        if let sorting = params.sorting {
            let sortItem = URLQueryItem(name: "sort", value: sorting.rawValue)
            items.append(sortItem)
            
            if sorting == .time {
                let sortDirectionItem = URLQueryItem(name: "sortDirection", value: "asc")
                items.append(sortDirectionItem)
            }
        }
        
        return items
    }
}
