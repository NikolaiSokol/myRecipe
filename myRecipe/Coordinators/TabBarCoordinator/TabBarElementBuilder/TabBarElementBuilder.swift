//
//  TabBarElementBuilder.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

struct TabBarElementBuilder {
    private func itemForTabBarElement(type: TabBarElementType) -> AnyView {
        switch type {
        case .mainScreenRoot:
            return Label(String(localized: .home), systemImage: "house").eraseToAnyView()
            
        case .savedRecipesRoot:
            return Label(String(localized: .saved), systemImage: "bookmark").eraseToAnyView()
            
        case .settingsScreenRoot:
            return Label(String(localized: .settings), systemImage: "gear").eraseToAnyView()
        }
    }
}

extension TabBarElementBuilder: TabBarElementBuilding {
    func buildTabBarElement(view: AnyView, type: TabBarElementType) -> TabBarElement {
        TabBarElement(
            type: type,
            view: view,
            item: itemForTabBarElement(type: type)
        )
    }
}
