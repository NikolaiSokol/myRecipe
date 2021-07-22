//
//  InFridgeNetworkManager.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import Foundation

struct InFridgeNetworkManager {
    
    private let session: URLSession = .shared
    private let searchBaseURL = "https://api.spoonacular.com/recipes/findByIngredients"
    private let autocompleteBaseURL = "https://api.spoonacular.com/food/ingredients/autocomplete"
    private let apiKey = "6553758da0eb441587641966ca80aeb9"
    
    typealias AutocompleteCompletion = (Result<[AutocompleteIngredientResponse], Error>) -> Void
    typealias RecipesCompletion = (Result<[SearchedRecipe], Error>) -> Void
    
    func loadAutocomplete(text: String, completion: @escaping AutocompleteCompletion) {
        var components = URLComponents(string: autocompleteBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "query", value: text),
            URLQueryItem(name: "number", value: "20"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else {
            completion(.failure(URLError.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([AutocompleteIngredientResponse].self, from: data)
                    let autocomplete = decodedResponse
                    completion(.success(autocomplete))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    completion(.failure(DecodingError.dataCorrupted(context)))
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.keyNotFound(key, context)))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.valueNotFound(value, context)))
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.typeMismatch(type, context)))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func loadRecipes(ingredients: String, completion: @escaping RecipesCompletion) {
        var components = URLComponents(string: searchBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "ingredients", value: ingredients),
            URLQueryItem(name: "ranking", value: "2"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

        guard let url = components?.url else {
            completion(.failure(URLError.invalidURL))
            return
        }
        let request = URLRequest(url: url)

        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([SearchedRecipe].self, from: data)
                    let recipe = decodedResponse
                    completion(.success(recipe))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    completion(.failure(DecodingError.dataCorrupted(context)))
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.keyNotFound(key, context)))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.valueNotFound(value, context)))
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.typeMismatch(type, context)))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
