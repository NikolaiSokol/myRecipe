//
//  QueryItemsRepresentable.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

protocol QueryItemsRepresentable {
    func queryItems() -> [URLQueryItem]
}
