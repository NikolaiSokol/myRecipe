//
//  ParametersViewFactory.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class ParametersViewFactory {
    
    func createTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        return label
    }
    
    func createChosenLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = text
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        return label
    }
    
    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textAlignment = .right
        textField.clearButtonMode = .whileEditing
        return textField
    }
    
    func createHorizontalStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stack.backgroundColor = UIColor(named: "secondBackground")
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 20
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return stack
    }
    
    func createVerticalStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 1
        return stack
    }
}
