//
//  SearchRecipesNetworkManager.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import UIKit

struct SearchRecipesNetworkManager {
    
    private let session: URLSession = .shared
    private let searchBaseURL = "https://api.spoonacular.com/recipes/complexSearch"
    private let autocompleteBaseURL = "https://api.spoonacular.com/recipes/autocomplete"
    private let apiKey = "6553758da0eb441587641966ca80aeb9"
    
    typealias SearchCompletion = (Result<SearchedRecipesResponse, Error>) -> Void
    typealias AutocompleteCompletion = (Result<[AutocompleteRecipeSearchResponse], Error>) -> Void
    
    func searchRecipesWith(text: String, offset: Int, number: Int, completion: @escaping SearchCompletion) {
        var components = URLComponents(string: searchBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "query", value: text),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "number", value: String(number)),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        loadRecipes(components: components) { result in
            completion(result)
        }
    }
    
    func searchRecipesWith(parameters: RecipesSearchParameters, offset: Int, number: Int, completion: @escaping SearchCompletion) {
        var components = URLComponents(string: searchBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "query", value: parameters.query),
            URLQueryItem(name: "cuisine", value: parameters.cuisine),
            URLQueryItem(name: "excludeCuisine", value: parameters.excludeCuisine),
            URLQueryItem(name: "diet", value: parameters.diet),
            URLQueryItem(name: "intolerances", value: parameters.intolerances),
            URLQueryItem(name: "equipment", value: parameters.equipment),
            URLQueryItem(name: "includeIngredients", value: parameters.includeIngredients),
            URLQueryItem(name: "excludeIngredients", value: parameters.excludeIngredients),
            URLQueryItem(name: "type", value: parameters.type),
            URLQueryItem(name: "instructionsRequired", value: parameters.instructionsRequired),
            URLQueryItem(name: "maxReadyTime", value: parameters.maxReadyTime),
            URLQueryItem(name: "sort", value: parameters.sort),
            URLQueryItem(name: "sortDirection", value: parameters.sortDirection),
            URLQueryItem(name: "minCarbs", value: parameters.minCarbs),
            URLQueryItem(name: "maxCarbs", value: parameters.maxCarbs),
            URLQueryItem(name: "minProtein", value: parameters.minProtein),
            URLQueryItem(name: "maxProtein", value: parameters.maxProtein),
            URLQueryItem(name: "minCalories", value: parameters.minCalories),
            URLQueryItem(name: "maxCalories", value: parameters.maxCalories),
            URLQueryItem(name: "minFat", value: parameters.minFat),
            URLQueryItem(name: "maxFat", value: parameters.maxFat),
            URLQueryItem(name: "minAlcohol", value: parameters.minAlcohol),
            URLQueryItem(name: "maxAlcohol", value: parameters.maxAlcohol),
            URLQueryItem(name: "minCaffeine", value: parameters.minCaffeine),
            URLQueryItem(name: "maxCaffeine", value: parameters.maxCaffeine),
            URLQueryItem(name: "minCopper", value: parameters.minCopper),
            URLQueryItem(name: "maxCopper", value: parameters.maxCopper),
            URLQueryItem(name: "minCalcium", value: parameters.minCalcium),
            URLQueryItem(name: "maxCalcium", value: parameters.maxCalcium),
            URLQueryItem(name: "minCholine", value: parameters.minCholine),
            URLQueryItem(name: "maxCholine", value: parameters.maxCholine),
            URLQueryItem(name: "minCholesterol", value: parameters.minCholesterol),
            URLQueryItem(name: "maxCholesterol", value: parameters.maxCholesterol),
            URLQueryItem(name: "minFluoride", value: parameters.minFluoride),
            URLQueryItem(name: "maxFluoride", value: parameters.maxFluoride),
            URLQueryItem(name: "minSaturatedFat", value: parameters.minSaturatedFat),
            URLQueryItem(name: "maxSaturatedFat", value: parameters.maxSaturatedFat),
            URLQueryItem(name: "minVitaminA", value: parameters.minVitaminA),
            URLQueryItem(name: "maxVitaminA", value: parameters.maxVitaminA),
            URLQueryItem(name: "minVitaminC", value: parameters.minVitaminC),
            URLQueryItem(name: "maxVitaminC", value: parameters.maxVitaminC),
            URLQueryItem(name: "minVitaminD", value: parameters.minVitaminD),
            URLQueryItem(name: "maxVitaminD", value: parameters.maxVitaminD),
            URLQueryItem(name: "minVitaminE", value: parameters.minVitaminE),
            URLQueryItem(name: "maxVitaminE", value: parameters.maxVitaminE),
            URLQueryItem(name: "minVitaminK", value: parameters.minVitaminK),
            URLQueryItem(name: "maxVitaminK", value: parameters.maxVitaminK),
            URLQueryItem(name: "minVitaminB1", value: parameters.minVitaminB1),
            URLQueryItem(name: "maxVitaminB1", value: parameters.maxVitaminB1),
            URLQueryItem(name: "minVitaminB2", value: parameters.minVitaminB2),
            URLQueryItem(name: "maxVitaminB2", value: parameters.maxVitaminB2),
            URLQueryItem(name: "minVitaminB3", value: parameters.minVitaminB3),
            URLQueryItem(name: "maxVitaminB3", value: parameters.maxVitaminB3),
            URLQueryItem(name: "minVitaminB5", value: parameters.minVitaminB5),
            URLQueryItem(name: "maxVitaminB5", value: parameters.maxVitaminB5),
            URLQueryItem(name: "minVitaminB6", value: parameters.minVitaminB6),
            URLQueryItem(name: "maxVitaminB6", value: parameters.maxVitaminB6),
            URLQueryItem(name: "minVitaminB12", value: parameters.minVitaminB12),
            URLQueryItem(name: "maxVitaminB12", value: parameters.maxVitaminB12),
            URLQueryItem(name: "minFiber", value: parameters.minFiber),
            URLQueryItem(name: "maxFiber", value: parameters.maxFiber),
            URLQueryItem(name: "minFolate", value: parameters.minFolate),
            URLQueryItem(name: "maxFolate", value: parameters.maxFolate),
            URLQueryItem(name: "minFolicAcid", value: parameters.minFolicAcid),
            URLQueryItem(name: "maxFolicAcid", value: parameters.maxFolicAcid),
            URLQueryItem(name: "minIodine", value: parameters.minIodine),
            URLQueryItem(name: "maxIodine", value: parameters.maxIodine),
            URLQueryItem(name: "minIron", value: parameters.minIron),
            URLQueryItem(name: "maxIron", value: parameters.maxIron),
            URLQueryItem(name: "minMagnesium", value: parameters.minMagnesium),
            URLQueryItem(name: "maxMagnesium", value: parameters.maxMagnesium),
            URLQueryItem(name: "minManganese", value: parameters.minManganese),
            URLQueryItem(name: "maxManganese", value: parameters.maxManganese),
            URLQueryItem(name: "minPhosphorus", value: parameters.minPhosphorus),
            URLQueryItem(name: "maxPhosphorus", value: parameters.maxPhosphorus),
            URLQueryItem(name: "minPotassium", value: parameters.minPotassium),
            URLQueryItem(name: "maxPotassium", value: parameters.maxPotassium),
            URLQueryItem(name: "minSelenium", value: parameters.minSelenium),
            URLQueryItem(name: "maxSelenium", value: parameters.maxSelenium),
            URLQueryItem(name: "minSodium", value: parameters.minSodium),
            URLQueryItem(name: "maxSodium", value: parameters.maxSodium),
            URLQueryItem(name: "minSugar", value: parameters.minSugar),
            URLQueryItem(name: "maxSugar", value: parameters.maxSugar),
            URLQueryItem(name: "minZinc", value: parameters.minZinc),
            URLQueryItem(name: "maxZinc", value: parameters.maxZinc),
            
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "number", value: String(number)),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        loadRecipes(components: components) { result in
            completion(result)
        }
    }
    
    private func loadRecipes(components: URLComponents?, completion: @escaping SearchCompletion) {
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(SearchedRecipesResponse.self, from: data)
                    let recipes = decodedResponse
                    completion(.success(recipes))
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
    
    func loadAutocomplete(text: String, completion: @escaping AutocompleteCompletion) {
        var components = URLComponents(string: autocompleteBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "query", value: text),
            URLQueryItem(name: "number", value: "10"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([AutocompleteRecipeSearchResponse].self, from: data)
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
