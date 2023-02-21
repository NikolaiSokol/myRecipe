//
//  SingleSelectionCarouselViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation
import Combine

final class SingleSelectionCarouselViewModel: ObservableObject {
    @Published var cells: [SingleSelectionCarouselCellViewModel] = []
    
    let currentSelectedId = CurrentValueSubject<UUID, Never>(UUID())
}
