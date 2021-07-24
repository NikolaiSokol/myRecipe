//
//  ImageLoadingManagerTests.swift
//  myRecipeTests
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import XCTest
@testable import myRecipe

final class ImageLoadingManagerTests: XCTestCase {

    var imageLoadingManager: ImageLoadingManager!

    override func tearDownWithError() throws {
        imageLoadingManager = nil
        try super.tearDownWithError()
    }

    func testThatImageLoadsSuccesfully() {
        imageLoadingManager = ImageLoadingManager(session: URLSession.shared)

        let expectation = expectation(description: #function)

        imageLoadingManager.loadImage(imageUrl: "https://spoonacular.com/cdn/ingredients_100x100/milk") { result in
            switch result {
            case.success(let image):
                XCTAssertNotNil(image)
                expectation.fulfill()
            case.failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 3)
    }
}
