//
//  MainScreenView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject private var viewState: MainScreenViewState
    private let output: MainScreenViewOutput?
    
    init(
        viewState: MainScreenViewState,
        output: MainScreenViewOutput?
    ) {
        self.viewState = viewState
        self.output = output
    }
    
    var body: some View {
        Text("Main Screen")
            .font(.title)
            .padding()
    }
}
