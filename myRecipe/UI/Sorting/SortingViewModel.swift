//
//  SortingViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import Foundation

final class SortingViewModel: ObservableObject {
    @Published var selectedOption: SortingOption = .default
    
    var options: [SortingOption] = []
    var tapHandler: ((SortingOption) -> Void)?
    
    func didTapSortingOption(_ option: SortingOption) {
        selectedOption = option
        tapHandler?(option)
    }
}
