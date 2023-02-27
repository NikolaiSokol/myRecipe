//
//  SearchScreenView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import SwiftUI

struct SearchScreenView: View {
    @ObservedObject private var state: SearchScreenViewState
    private let output: SearchScreenViewOutput
    
    init(
        state: SearchScreenViewState,
        output: SearchScreenViewOutput
    ) {
        self.state = state
        self.output = output
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
    }
}
