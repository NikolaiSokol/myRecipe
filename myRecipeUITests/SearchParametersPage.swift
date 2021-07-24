//
//  SearchParametersPage.swift
//  myRecipeUITests
//
//  Created by Nikolai Sokol on 24.07.2021.
//

import XCTest

final class SearchParametersPage: Page {
    var app: XCUIApplication

    init(app: XCUIApplication) {
        self .app = app
    }

    func tapSwitch() -> Self {
        let instructionSwitch = app.switches["instructionsRequiredSwitch"]
        instructionSwitch.tap()
        XCTAssertEqual(instructionSwitch.value as! String, "1")
        return self
    }

    func tapSearchButton() -> SearchPage {
        let button = app.buttons["searchWithParametersButton"]
        button.tap()
        return SearchPage(app: app)
    }
}
