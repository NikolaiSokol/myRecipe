//
//  ErrorViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import Foundation

final class ErrorViewModel {
    let title: String?
    let subtitle: String?
    let buttonText: String?
    let buttonAction: (() -> Void)?
    
    init(
        title: String?,
        subtitle: String? = nil,
        buttonText: String?,
        buttonAction: (() -> Void)?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttonText = buttonText
        self.buttonAction = buttonAction
    }
    
    func didTapActionButton() {
        buttonAction?()
    }
}
