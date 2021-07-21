//
//  MinMaxViewFactory.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 20.07.2021.
//

import Foundation

final class MinMaxViewFactory {
    
    private let parametersViewFactory: ParametersViewFactory
    
    init(parametersViewFactory: ParametersViewFactory) {
        self.parametersViewFactory = parametersViewFactory
    }
    
    func create(title: String) -> MinMaxView {
        MinMaxView(frame: .zero, viewsFactory: parametersViewFactory, title: title)
    }
}
