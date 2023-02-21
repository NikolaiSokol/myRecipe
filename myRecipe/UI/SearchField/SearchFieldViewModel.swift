//
//  SearchFieldViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 20.02.2023.
//

import Combine

final class SearchFieldViewModel: ObservableObject {
    @Published var text = ""
    let endEditingSubject = PassthroughSubject<Void, Never>()
    
    func didTapClearButton() {
        text.removeAll()
    }
    
    func endEditing() {
        endEditingSubject.send()
    }
}
