//
//  SettingsScreenView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

struct SettingsScreenView: View {
    @ObservedObject private var viewState: SettingsScreenViewState
    private let output: SettingsScreenViewOutput?
    
    init(
        viewState: SettingsScreenViewState,
        output: SettingsScreenViewOutput?
    ) {
        self.viewState = viewState
        self.output = output
    }
    
    var body: some View {
        Text("Settings Screen")
    }
}
