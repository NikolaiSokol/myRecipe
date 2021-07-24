//
//  RecipeNetworkManagerTests.swift
//  myRecipeTests
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import XCTest
@testable import myRecipe

final class RecipeNetworkManagerTests: XCTestCase {

    var recipeNetworkManager: RecipeNetworkManager!

    var mockSession: MockURLSession!

    override func tearDownWithError() throws {
        recipeNetworkManager = nil
        mockSession = nil
        try super.tearDownWithError()
    }

    func testThatRecipeParsesSuccesfully() {
        mockSession = MockSession.shared.create(fromJsonFile: "Recipe", andError: nil)
        recipeNetworkManager = RecipeNetworkManager(session: mockSession)

        let expectation = expectation(description: #function)

        recipeNetworkManager.loadRecipe(id: 1) { result in
            switch result {
            case.success(let recipe):
                XCTAssertEqual(recipe.readyInMinutes, 45)
                expectation.fulfill()
            case.failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 3)
    }
}
