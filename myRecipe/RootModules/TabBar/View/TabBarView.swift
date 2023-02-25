//
//  TabBarView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject private var state: TabBarViewState
    private let output: TabBarViewOutput
    
    init(
        state: TabBarViewState,
        output: TabBarViewOutput
    ) {
        self.state = state
        self.output = output
    }
    
    var body: some View {
        TabView(selection: $state.selectedTab) {
            ForEach(state.tabs, id: \.type) { element in
                element.view
                    .tabItem {
                        element.item
                    }
                    .tag(element.type)
            }
        }
    }
}
