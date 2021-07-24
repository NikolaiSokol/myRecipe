//
//  Page.swift
//  myRecipeUITests
//
//  Created by Nikolai Sokol on 24.07.2021.
//

import XCTest

protocol Page {
    var app: XCUIApplication { get }

    init(app: XCUIApplication)
}
