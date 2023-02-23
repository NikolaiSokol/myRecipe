//
//  RecipeScreenView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import SwiftUI

struct RecipeScreenView: View {
    @ObservedObject private var state: RecipeScreenViewState
    private let output: RecipeScreenViewOutput
    
    init(
        state: RecipeScreenViewState,
        output: RecipeScreenViewOutput
    ) {
        self.state = state
        self.output = output
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            Text("Recipe id: \(state.recipeId)")
        }
    }
}
