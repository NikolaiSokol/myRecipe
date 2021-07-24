//
//  UITests.swift
//  myRecipeUITests
//
//  Created by Nikolai Sokol on 11.06.2021.
//

import XCTest

class UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }

    func testSearchScreen() {
        app.tabBars.buttons["Search"].tap()

        let page = SearchPage(app: app)
        page
            .typeTextInSearchBar("Pasta")
            .checkYouMayLikeLabelRemoved()
            .checkThatFirstCellNameMatchesToSearch()
            .tapParametersButton()
            .tapSwitch()
            .tapSearchButton()
            .tapFirstTableViewCell()
            .tapDetailedNutrientsButton()
    }

    func testInFridgeScreen() {
        app.tabBars.buttons["In Fridge"].tap()

        let page = InFridgePage(app: app)
        page
            .tapAddButton()
            .addIngredient("Apple")
            .tapAddButton()
            .addIngredient("Sugar")
            .tapAddButton()
            .addIngredient("Flour")
            .checkElementsAdded()
            .removeSecondIngredient()
            .tapSearchButton()
    }
}
