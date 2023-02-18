//
//  TabBarView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject private var viewState: TabBarViewState
    private let output: TabBarViewOutput
    
    init(
        viewState: TabBarViewState,
        output: TabBarViewOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
    
    var body: some View {
        TabView(selection: $viewState.selectedTab) {
            ForEach(viewState.tabs) { element in
                element.view
                    .tabItem {
                        element.item
                    }
                    .tag(element.type)
            }
        }
    }
}
