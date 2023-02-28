//
//  SearchServicing.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

protocol SearchServicing {
    func search(params: SearchParameters) async throws -> SearchResults
    func loadAutocomplete(query: String, number: Int) async throws -> [SearchAutocomplete]
}
