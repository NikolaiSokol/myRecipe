//
//  IngredientsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class IngredientsView: UIView {

    private let viewsFactory: ParametersViewFactory
    
    var includedIngredients = ""
    var excludedIngredients = ""
    
    private lazy var ingredientsGroupStackView: UIStackView = {
        let stack = viewsFactory.createVerticalStack()
        stack.addArrangedSubview(includeIngredientsStackView)
        stack.addArrangedSubview(excludeIngredientsStackView)
        return stack
    }()

    private lazy var includeIngredientsStackView: UIStackView = {
        let stack = viewsFactory.createHorizontalStack()
        stack.addArrangedSubview(viewsFactory.createTitleLabel(text: "Include Ingredients"))
        stack.addArrangedSubview(includeIngredientsTextField)
        return stack
    }()

    private lazy var includeIngredientsTextField: UITextField = {
        let textField = viewsFactory.createTextField(placeholder: "tomato, cheese")
        textField.addTarget(self, action: #selector(includeIngredientsDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var excludeIngredientsStackView: UIStackView = {
        let stack = viewsFactory.createHorizontalStack()
        stack.addArrangedSubview(viewsFactory.createTitleLabel(text: "Exclude Ingredients"))
        stack.addArrangedSubview(excludeIngredientsTextField)
        return stack
    }()
    
    private lazy var excludeIngredientsTextField: UITextField = {
        let textField = viewsFactory.createTextField(placeholder: "eggs")
        textField.addTarget(self, action: #selector(excludeIngredientsDidChange), for: .editingChanged)
        return textField
    }()
    
    init(frame: CGRect, viewsFactory: ParametersViewFactory) {
        self.viewsFactory = viewsFactory
        super.init(frame: frame)
        setupViews()
        setupAutoLayout()
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(ingredientsGroupStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            ingredientsGroupStackView.topAnchor.constraint(equalTo: topAnchor),
            ingredientsGroupStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ingredientsGroupStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ingredientsGroupStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func includeIngredientsDidChange(_ textField: UITextField) {
        if let text = textField.text {
            includedIngredients = text
        }
    }
    
    @objc private func excludeIngredientsDidChange(_ textField: UITextField) {
        if let text = textField.text {
            excludedIngredients = text
        }
    }
}
