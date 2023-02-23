//
//  RecipesVerticalListViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation
import Combine

final class RecipesVerticalListViewModel: ObservableObject {
    @Published var cards: [HorizontalRecipeCardViewModel] = []
    @Published var contentState: ViewContentState = .skeleton
    
    let scrollOffsetSubject = CurrentValueSubject<CGFloat, Never>(.zero)
    let scrollToTopSubject = PassthroughSubject<Void, Never>()
    var errorViewModel: ErrorViewModel?
    var refreshHandler: (() -> Void)?
    
    func scrollToTop() {
        scrollToTopSubject.send()
    }
    
    func refresh() {
        refreshHandler?()
    }
}
