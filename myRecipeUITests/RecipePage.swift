//
//  RecipePage.swift
//  myRecipeUITests
//
//  Created by Nikolai Sokol on 24.07.2021.
//

import XCTest

final class RecipePage: Page {
    var app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func tapDetailedNutrientsButton() {
        let button = app.buttons["Detailed Nutrients"]
        button.tap()
    }
}
