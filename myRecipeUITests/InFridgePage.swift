//
//  InFridgePage.swift
//  myRecipeUITests
//
//  Created by Nikolai Sokol on 24.07.2021.
//

import XCTest

final class InFridgePage: Page {
    var app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func tapAddButton() -> Self {
        let button = app.buttons["addIngredientButton"]
        button.tap()
        XCTAssertTrue(app.keyboards.count > 0)
        return self
    }

    func addIngredient(_ ingredien: String) -> Self {
        let searchBar = app.searchFields["Search for Ingredients"]
        searchBar.typeText(ingredien)
        app.keyboards.buttons["Done"].tap()
        return self
    }

    func checkElementsAdded() -> Self {
        XCTAssertTrue(app.collectionViews.children(matching:.any).element(boundBy: 0).exists)
        XCTAssertTrue(app.collectionViews.children(matching:.any).element(boundBy: 1).exists)
        XCTAssertTrue(app.collectionViews.children(matching:.any).element(boundBy: 2).exists)

        return self
    }

    func removeSecondIngredient() -> Self {
        let secondCell = app.collectionViews.children(matching:.any).element(boundBy: 1)
        let button = secondCell.buttons["deleteIngredientButton"]
        button.tap()
        return self
    }

    func tapSearchButton() {
        let button = app.buttons["searchByIngredientsButton"]
        button.tap()
        XCTAssertTrue(app.tables.children(matching:.any).element(boundBy: 0).exists)
    }
}
