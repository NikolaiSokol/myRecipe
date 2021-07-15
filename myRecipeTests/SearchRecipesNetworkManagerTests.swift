//
//  SearchRecipesNetworkManagerTests.swift
//  myRecipeTests
//
//  Created by Nikolai Sokol on 11.06.2021.
//

import XCTest
@testable import myRecipe

class SearchRecipesNetworkManagerTests: XCTestCase {
    
    var searchRecipesNetworkManager: SearchRecipesNetworkManager?

    override func setUpWithError() throws {
        try super.setUpWithError()
        searchRecipesNetworkManager = SearchRecipesNetworkManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        searchRecipesNetworkManager = nil
    }
    
    func testThatSearchWithTextReturnsTenRecipes() {
        let expectation = expectation(description: "Recipes are loaded")
        
        searchRecipesNetworkManager?.searchRecipesWith(text: "pasta", offset: 0, number: 10) { response in
            switch response {
            case .success(let recipes):
                XCTAssertEqual(recipes.results.count, 10)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}
