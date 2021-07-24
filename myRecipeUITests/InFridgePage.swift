//
//  InFridge.swift
//  myRecipeUITests
//
//  Created by Nikolai Sokol on 24.07.2021.
//

import XCTest

final class inFridgePage: Page {
    var app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func addIngredient(_ ingredien: String) -> Self {
        let addButton = app.buttons["addIngredientButton"]
        addButton.tap()
        return self
    }
}
