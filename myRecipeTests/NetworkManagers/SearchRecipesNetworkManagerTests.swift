//
//  SearchRecipesNetworkManagerTests.swift
//  myRecipeTests
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import XCTest
@testable import myRecipe

final class SearchRecipesNetworkManagerTests: XCTestCase {

    var searchNetworkManager: SearchRecipesNetworkManager!

    var mockSession: MockURLSession!

    override func tearDownWithError() throws {
        searchNetworkManager = nil
        mockSession = nil
        try super.tearDownWithError()
    }

    // MARK: - Autocomplete

    func testThatAutocompleteParsesSuccesfully() {
        mockSession = MockSession.shared.create(fromJsonFile: "SearchAutocomplete", andError: nil)
        searchNetworkManager = SearchRecipesNetworkManager(session: mockSession)

        let expectation = expectation(description: #function)

        searchNetworkManager.loadAutocomplete(text: "") { result in
            switch result {
            case.success(let autocompletes):
                XCTAssertEqual(autocompletes.count, 10)
                expectation.fulfill()
            case.failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 3)
    }

    // MARK: - Random Recipe

    func testThatRandomRecipesParseSuccesfully() {
        mockSession = MockSession.shared.create(fromJsonFile: "RandomRecipes", andError: nil)
        searchNetworkManager = SearchRecipesNetworkManager(session: mockSession)

        let expectation = expectation(description: #function)

        searchNetworkManager.loadRandomRecipes { result in
            switch result {
            case.success(let random):
                XCTAssertEqual(random.recipes.count, 10)
                expectation.fulfill()
            case.failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 3)
    }


    // MARK: - Search With Text

    func testThatSearchWithTextParsesSuccesfully() {
        mockSession = MockSession.shared.create(fromJsonFile: "Search", andError: nil)
        searchNetworkManager = SearchRecipesNetworkManager(session: mockSession)

        let expectation = expectation(description: #function)

        searchNetworkManager.searchRecipesWith(text: "", offset: 0, number: 0) { result in
            switch result {
            case.success(let recipes):
                XCTAssertEqual(recipes.results.count, 10)
                expectation.fulfill()
            case.failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 3)
    }

    func testThatSearchWithTextReturnsError() {
        mockSession = MockSession.shared.create(fromJsonFile: "Wrong", andError: URLError.invalidURL)
        searchNetworkManager = SearchRecipesNetworkManager(session: mockSession)

        let expectation = expectation(description: #function)

        searchNetworkManager.searchRecipesWith(text: "", offset: 0, number: 0) { result in
            switch result {
            case.success(let recipes):
                XCTAssertNil(recipes)
                expectation.fulfill()
            case.failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3)
    }

    // MARK: - Search With Parameters

    func testThatSearchWithParametersParsesSuccesfully() {
        let parameters = RecipesSearchParameters(query: "", cuisine: "", excludeCuisine: "", diet: "", intolerances: "", equipment: "", includeIngredients: "", excludeIngredients: "", type: "", instructionsRequired: "", maxReadyTime: "", sort: "", sortDirection: "", minCarbs: "", maxCarbs: "", minProtein: "", maxProtein: "", minCalories: "", maxCalories: "", minFat: "", maxFat: "", minAlcohol: "", maxAlcohol: "", minCaffeine: "", maxCaffeine: "", minCopper: "", maxCopper: "", minCalcium: "", maxCalcium: "", minCholine: "", maxCholine: "", minCholesterol: "", maxCholesterol: "", minFluoride: "", maxFluoride: "", minSaturatedFat: "", maxSaturatedFat: "", minVitaminA: "", maxVitaminA: "", minVitaminC: "", maxVitaminC: "", minVitaminD: "", maxVitaminD: "", minVitaminE: "", maxVitaminE: "", minVitaminK: "", maxVitaminK: "", minVitaminB1: "", maxVitaminB1: "", minVitaminB2: "", maxVitaminB2: "", minVitaminB3: "", maxVitaminB3: "", minVitaminB5: "", maxVitaminB5: "", minVitaminB6: "", maxVitaminB6: "", minVitaminB12: "", maxVitaminB12: "", minFiber: "", maxFiber: "", minFolate: "", maxFolate: "", minFolicAcid: "", maxFolicAcid: "", minIodine: "", maxIodine: "", minIron: "", maxIron: "", minMagnesium: "", maxMagnesium: "", minManganese: "", maxManganese: "", minPhosphorus: "", maxPhosphorus: "", minPotassium: "", maxPotassium: "", minSelenium: "", maxSelenium: "", minSodium: "", maxSodium: "", minSugar: "", maxSugar: "", minZinc: "", maxZinc: "")

        mockSession = MockSession.shared.create(fromJsonFile: "Search", andError: nil)
        searchNetworkManager = SearchRecipesNetworkManager(session: mockSession)

        let expectation = expectation(description: #function)

        searchNetworkManager.searchRecipesWith(parameters: parameters, offset: 0, number: 0) { result in
            switch result {
            case.success(let recipes):
                XCTAssertEqual(recipes.results.count, 10)
                expectation.fulfill()
            case.failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 3)
    }
}
