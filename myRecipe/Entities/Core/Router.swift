//
//  Router.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class Router: ObservableObject {
    @Published var navigableViews: [NavigableView] = []
}

extension Router: Routable {
    func present(_ view: NavigableView) {
        navigableViews.append(view)
    }
    
    func popToRoot() {
        navigableViews.removeAll()
    }
    
    func pop() {
        navigableViews.removeLast()
    }
}
