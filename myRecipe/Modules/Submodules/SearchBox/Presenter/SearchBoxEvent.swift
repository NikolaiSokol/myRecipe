//
//  SearchBoxEvent.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

enum SearchBoxEvent {
    case textChanged(String)
    case returnKeyTapped
    case textFieldBecameFocused
}
