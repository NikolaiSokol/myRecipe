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
    @Published var isLoadingNextPage = false
    
    let recipeCardAppearedSubject = CurrentValueSubject<Int, Never>(.zero)
    let scrollOffsetSubject = CurrentValueSubject<CGFloat, Never>(.zero)
    let scrollToTopSubject = PassthroughSubject<Void, Never>()
    
    var isRefreshable = true
    var errorViewModel: ErrorViewModel?
    var refreshHandler: (() -> Void)?
    
    func scrollToTop() {
        scrollToTopSubject.send()
    }
    
    func refresh() {
        refreshHandler?()
    }
    
    func updateContentState(to state: ViewContentState) {
        if contentState != state {
            contentState = state
        }
    }
    
    func onCardAppear(id: Int) {
        recipeCardAppearedSubject.send(id)
    }
    
    func updateIsLoadingNextPage(to newValue: Bool) {
        if isLoadingNextPage != newValue {
            isLoadingNextPage = newValue
        }
    }
}
