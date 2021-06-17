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
            URLQueryItem(name: "instructionsRequired", value: String(parameters.instructionsRequired)),
            URLQueryItem(name: "titleMatch", value: parameters.titleMatch),
            URLQueryItem(name: "maxReadyTime", value: String(parameters.maxReadyTime)),
            URLQueryItem(name: "ignorePantry", value: String(parameters.ignorePantry)),
            URLQueryItem(name: "sort", value: parameters.sort),
            URLQueryItem(name: "sortDirection", value: parameters.sortDirection),
            URLQueryItem(name: "minCarbs", value: String(parameters.minCarbs)),
            URLQueryItem(name: "maxCarbs", value: String(parameters.maxCarbs)),
            URLQueryItem(name: "minProtein", value: String(parameters.minProtein)),
            URLQueryItem(name: "maxProtein", value: String(parameters.maxProtein)),
            URLQueryItem(name: "minCalories", value: String(parameters.minCalories)),
            URLQueryItem(name: "maxCalories", value: String(parameters.maxCalories)),
            URLQueryItem(name: "minFat", value: String(parameters.minFat)),
            URLQueryItem(name: "maxFat", value: String(parameters.maxFat)),
            URLQueryItem(name: "minAlcohol", value: String(parameters.minAlcohol)),
            URLQueryItem(name: "maxAlcohol", value: String(parameters.maxAlcohol)),
            URLQueryItem(name: "minCaffeine", value: String(parameters.minCaffeine)),
            URLQueryItem(name: "maxCaffeine", value: String(parameters.maxCaffeine)),
            URLQueryItem(name: "minCopper", value: String(parameters.minCopper)),
            URLQueryItem(name: "maxCopper", value: String(parameters.maxCopper)),
            URLQueryItem(name: "minCalcium", value: String(parameters.minCalcium)),
            URLQueryItem(name: "maxCalcium", value: String(parameters.maxCalcium)),
            URLQueryItem(name: "minCholine", value: String(parameters.minCholine)),
            URLQueryItem(name: "maxCholine", value: String(parameters.maxCholine)),
            URLQueryItem(name: "minCholesterol", value: String(parameters.minCholesterol)),
            URLQueryItem(name: "maxCholesterol", value: String(parameters.maxCholesterol)),
            URLQueryItem(name: "minFluoride", value: String(parameters.minFluoride)),
            URLQueryItem(name: "maxFluoride", value: String(parameters.maxFluoride)),
            URLQueryItem(name: "minSaturatedFat", value: String(parameters.minSaturatedFat)),
            URLQueryItem(name: "maxSaturatedFat", value: String(parameters.maxSaturatedFat)),
            URLQueryItem(name: "minVitaminA", value: String(parameters.minVitaminA)),
            URLQueryItem(name: "maxVitaminA", value: String(parameters.maxVitaminA)),
            URLQueryItem(name: "minVitaminC", value: String(parameters.minVitaminC)),
            URLQueryItem(name: "maxVitaminC", value: String(parameters.maxVitaminC)),
            URLQueryItem(name: "minVitaminD", value: String(parameters.minVitaminD)),
            URLQueryItem(name: "maxVitaminD", value: String(parameters.maxVitaminD)),
            URLQueryItem(name: "minVitaminE", value: String(parameters.minVitaminE)),
            URLQueryItem(name: "maxVitaminE", value: String(parameters.maxVitaminE)),
            URLQueryItem(name: "minVitaminK", value: String(parameters.minVitaminK)),
            URLQueryItem(name: "maxVitaminK", value: String(parameters.maxVitaminK)),
            URLQueryItem(name: "minVitaminB1", value: String(parameters.minVitaminB1)),
            URLQueryItem(name: "maxVitaminB1", value: String(parameters.maxVitaminB1)),
            URLQueryItem(name: "minVitaminB2", value: String(parameters.minVitaminB2)),
            URLQueryItem(name: "maxVitaminB2", value: String(parameters.maxVitaminB2)),
            URLQueryItem(name: "minVitaminB3", value: String(parameters.minVitaminB3)),
            URLQueryItem(name: "maxVitaminB3", value: String(parameters.maxVitaminB3)),
            URLQueryItem(name: "minVitaminB5", value: String(parameters.minVitaminB5)),
            URLQueryItem(name: "maxVitaminB5", value: String(parameters.maxVitaminB5)),
            URLQueryItem(name: "minVitaminB6", value: String(parameters.minVitaminB6)),
            URLQueryItem(name: "maxVitaminB6", value: String(parameters.maxVitaminB6)),
            URLQueryItem(name: "minVitaminB12", value: String(parameters.minVitaminB12)),
            URLQueryItem(name: "maxVitaminB12", value: String(parameters.maxVitaminB12)),
            URLQueryItem(name: "minFiber", value: String(parameters.minFiber)),
            URLQueryItem(name: "maxFiber", value: String(parameters.maxFiber)),
            URLQueryItem(name: "minFolate", value: String(parameters.minFolate)),
            URLQueryItem(name: "maxFolate", value: String(parameters.maxFolate)),
            URLQueryItem(name: "minFolicAcid", value: String(parameters.minFolicAcid)),
            URLQueryItem(name: "maxFolicAcid", value: String(parameters.maxFolicAcid)),
            URLQueryItem(name: "minIodine", value: String(parameters.minIodine)),
            URLQueryItem(name: "maxIodine", value: String(parameters.maxIodine)),
            URLQueryItem(name: "minIron", value: String(parameters.minIron)),
            URLQueryItem(name: "maxIron", value: String(parameters.maxIron)),
            URLQueryItem(name: "minMagnesium", value: String(parameters.minMagnesium)),
            URLQueryItem(name: "maxMagnesium", value: String(parameters.maxMagnesium)),
            URLQueryItem(name: "minManganese", value: String(parameters.minManganese)),
            URLQueryItem(name: "maxManganese", value: String(parameters.maxManganese)),
            URLQueryItem(name: "minPhosphorus", value: String(parameters.minPhosphorus)),
            URLQueryItem(name: "maxPhosphorus", value: String(parameters.maxPhosphorus)),
            URLQueryItem(name: "minPotassium", value: String(parameters.minPotassium)),
            URLQueryItem(name: "maxPotassium", value: String(parameters.maxPotassium)),
            URLQueryItem(name: "minSelenium", value: String(parameters.minSelenium)),
            URLQueryItem(name: "maxSelenium", value: String(parameters.maxSelenium)),
            URLQueryItem(name: "minSodium", value: String(parameters.minSodium)),
            URLQueryItem(name: "maxSodium", value: String(parameters.maxSodium)),
            URLQueryItem(name: "minSugar", value: String(parameters.minSugar)),
            URLQueryItem(name: "maxSugar", value: String(parameters.maxSugar)),
            URLQueryItem(name: "minZinc", value: String(parameters.minZinc)),
            URLQueryItem(name: "maxZinc", value: String(parameters.maxZinc)),
            
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
