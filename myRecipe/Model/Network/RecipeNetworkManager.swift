//
//  RecipeNetworkManager.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 12.07.2021.
//

import Foundation

struct RecipeNetworkManager {
    
    private let session: URLSession = .shared
    private let baseURL = "https://api.spoonacular.com/recipes/"
    private let apiKey = "6553758da0eb441587641966ca80aeb9"
    
    typealias RecipeCompletion = (Result<RecipeResponse, Error>) -> Void
    
    func loadRecipe(id: Int, completion: @escaping RecipeCompletion) {
        var components = URLComponents(string: baseURL + String(id) + "/information")
        components?.queryItems = [
            URLQueryItem(name: "includeNutrition", value: "true"),
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
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
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
}
