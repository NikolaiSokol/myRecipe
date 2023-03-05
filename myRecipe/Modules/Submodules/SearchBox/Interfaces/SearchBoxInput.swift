//
//  SearchBoxInput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation

protocol SearchBoxInput: AnyObject {
    func configure(shouldBeFocused: Bool)
    func endEditing()
    func getText() -> String
    func updateText(_ text: String)
}
