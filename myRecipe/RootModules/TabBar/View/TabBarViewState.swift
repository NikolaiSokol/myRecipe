//
//  TabBarViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class TabBarViewState: ObservableObject {
    @Published var tabs: [TabBarElement] = []
    @Published var selectedTab = TabBarElementType.mainScreenRoot
}
