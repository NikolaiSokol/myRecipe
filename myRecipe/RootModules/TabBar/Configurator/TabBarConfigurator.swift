//
//  TabBarConfigurator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

final class TabBarConfigurator {
    func configure(output: TabBarOutput) -> RootModule<TabBarInput> {
        let viewState = TabBarViewState()
        
        let viewModel = TabBarViewModel(
            viewState: viewState,
            output: output
        )
        
        let view = TabBarView(viewState: viewState, output: viewModel)
        
        return (view.eraseToAnyView(), viewModel)
    }
}
