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
    
    let shouldBeFocusedSubject = CurrentValueSubject<Bool, Never>(true)
    let didBecomeFocusedSubject = PassthroughSubject<Void, Never>()
    
    func didTapClearButton() {
        text.removeAll()
        shouldBeFocusedSubject.send(true)
    }
    
    func endEditing() {
        shouldBeFocusedSubject.send(false)
    }
}
