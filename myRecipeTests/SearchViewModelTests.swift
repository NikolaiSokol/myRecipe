//
//  SearchViewModelTests.swift
//  myRecipeTests
//
//  Created by Nikolai Sokol on 24.07.2021.
//

import XCTest
@testable import myRecipe

final class SearchViewModelTests: XCTestCase {

    var searchViewModel: SearchViewModel!

    override func setUpWithError() throws {
        searchViewModel = SearchViewModel(networkManager: MockSearchRecipesNetworkManager(), imageLoader: MockImageLoadingManager())
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        searchViewModel = nil
        try super.tearDownWithError()
    }

    func testThatChangingSearchedTextCausesAutocompletionLoading() {
        let expectation = expectation(description: #function)

        searchViewModel.searchedText = "Text"

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.searchViewModel.autocompletions.count, 1)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testThatImageLoadsSuccesfully() {
        let expectation = expectation(description: #function)

        searchViewModel.loadImage(url: "") { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
}

final class MockSearchRecipesNetworkManager: SearchRecipesNetworkManagerProtocol {

    func loadAutocomplete(text: String, completion: @escaping AutocompleteCompletion) {
        completion(.success([AutocompleteRecipeSearch(title: "")]))
    }

    func loadRandomRecipes(completion: @escaping RandomCompletion) {}

    func searchRecipesWith(text: String, offset: Int, number: Int, completion: @escaping SearchCompletion) {}

    func searchRecipesWith(parameters: RecipesSearchParameters, offset: Int, number: Int, completion: @escaping SearchCompletion) {}
}

final class MockImageLoadingManager: ImageLoadingManagerProtocol {
    func loadImage(imageUrl: String, completion: @escaping ImageCompletion) {
        completion(.success(UIImage(systemName: "plus")!))
    }
}
