//
//  NutrientsBlockViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

final class NutrientsBlockViewModel: ObservableObject {
    @Published var contentState: ViewContentState = .skeleton
    
    var nutrients: [Nutrient] = []
    var viewMoreTapHandler: (() -> Void)?
    
    func didTapViewMore() {
        viewMoreTapHandler?()
    }
}
