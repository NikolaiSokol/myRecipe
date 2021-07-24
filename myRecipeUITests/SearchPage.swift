//
//  SearchPage.swift
//  myRecipeUITests
//
//  Created by Nikolai Sokol on 24.07.2021.
//

import XCTest

final class SearchPage: Page {

    var app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func typeTextInSearchBar(_ text: String) -> Self {
        let searchBar = app.searchFields["Search"]
        searchBar.tap()
        XCTAssertTrue(app.keyboards.count > 0)
        searchBar.typeText(text)
        app.keyboards.buttons["Search"].tap()
        return self
    }

    func checkYouMayLikeLabelRemoved() -> Self {
        XCTAssertFalse(app.staticTexts["You may like these recipes"].exists)
        return self
    }

    func checkThatFirstCellNameMatchesToSearch() -> Self {
        let firstCell = app.tables.children(matching:.any).element(boundBy: 0)
        let label = firstCell.staticTexts["Pasta With Tuna"]
        XCTAssertTrue(label.exists)
        return self
    }

    func tapParametersButton() -> SearchParametersPage {
        let button = app.buttons["searchParametersButton"]
        button.tap()
        return SearchParametersPage(app: app)
    }

    func tapFirstTableViewCell() -> RecipePage {
        let table = app.tables.matching(identifier: "searchTableView")
        let cell = table.cells.element(matching: .cell, identifier: "cell_0")
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.tap()
        return RecipePage(app: app)
    }
}
