//
//  SearchedRecipe.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import Foundation

struct SearchedRecipe: Decodable {
    let id: Int
    let title: String
    let image: String
}
