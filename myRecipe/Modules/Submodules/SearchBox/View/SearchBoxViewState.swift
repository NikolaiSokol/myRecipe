//
//  SearchBoxViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation
import Combine

final class SearchBoxViewState: ObservableObject {
    @Published var text = ""
    
    let endEditingSubject = PassthroughSubject<Void, Never>()
    
    func didTapClearButton() {
        text.removeAll()
    }
    
    func endEditing() {
        endEditingSubject.send()
    }
}
