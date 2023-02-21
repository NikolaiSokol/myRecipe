//
//  SingleSelectionCarouselCellViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation

final class SingleSelectionCarouselCellViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let text: String
    let tapHandler: (String) -> Void
    
    @Published var isSelected: Bool
    
    init(
        text: String,
        tapHandler: @escaping (String) -> Void,
        isSelected: Bool = false
    ) {
        self.text = text
        self.tapHandler = tapHandler
        self.isSelected = isSelected
    }
    
    func didTapCell() {
        tapHandler(text)
    }
}

extension SingleSelectionCarouselCellViewModel: Equatable {
    static func == (
        lhs: SingleSelectionCarouselCellViewModel,
        rhs: SingleSelectionCarouselCellViewModel
    ) -> Bool {
        lhs.id == rhs.id && lhs.text == rhs.text
    }
}
