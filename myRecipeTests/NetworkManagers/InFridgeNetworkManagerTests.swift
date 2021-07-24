//
//  InFridgeNetworkManagerTests.swift
//  myRecipeTests
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import XCTest
@testable import myRecipe

final class InFridgeNetworkManagerTests: XCTestCase {

    var inFridgeNetworkManager: InFridgeNetworkManager!

    var mockSession: MockURLSession!

    override func tearDownWithError() throws {
        inFridgeNetworkManager = nil
        mockSession = nil
        try super.tearDownWithError()
    }

    func testThatAutocompleteParsesSuccesfully() {
        mockSession = MockSession.shared.create(fromJsonFile: "IngredientsAutocomplete", andError: nil)
        inFridgeNetworkManager = InFridgeNetworkManager(session: mockSession)

        let expectation = expectation(description: "Autocomplete")

        inFridgeNetworkManager.loadAutocomplete(text: "") { result in
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

    func testThatRecipesParseSuccesfully() {
        mockSession = MockSession.shared.create(fromJsonFile: "SearchByIngredients", andError: nil)
        inFridgeNetworkManager = InFridgeNetworkManager(session: mockSession)

        let expectation = expectation(description: "Search by Ingredients")

        inFridgeNetworkManager.loadRecipes(ingredients: "") { result in
            switch result {
            case.success(let ingredients):
                XCTAssertEqual(ingredients.count, 10)
                expectation.fulfill()
            case.failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 3)
    }
}
