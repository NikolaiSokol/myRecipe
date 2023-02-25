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
        
        let presenter = TabBarPresenter(
            viewState: viewState,
            output: output
        )
        
        let view = TabBarView(viewState: viewState, output: presenter)
        
        return (view.eraseToAnyView(), presenter)
    }
}
