//
//  CarbsProteinFatCaloriesView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class CarbsProteinFatCaloriesView: UIView {

    private let viewsBuilder: ParametersViewBuilder
    
    private let min = "0"
    private let max = "100"
    
    var minCarbs = "0"
    var maxCarbs = "1000"
    
    var minProtein = "0"
    var maxProtein = "1000"
    
    var minFat = "0"
    var maxFat = "1000"
    
    var minCalories = "0"
    var maxCalories = "10000"
    
    private lazy var carbsProteinFatCaloriesGroupStackView: UIStackView = {
        let stack = viewsBuilder.buildVerticalStack()
        stack.addArrangedSubview(carbsStackView)
        stack.addArrangedSubview(proteinStackView)
        stack.addArrangedSubview(fatStackView)
        stack.addArrangedSubview(caloriesStackView)
        return stack
    }()
    
    private lazy var carbsStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Carbs"))
        stack.addArrangedSubview(carbsMinMaxStack)
        return stack
    }()
    
    private lazy var carbsMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minCarbsDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxCarbsDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()

    private lazy var proteinStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Protein"))
        stack.addArrangedSubview(proteinMinMaxStack)
        return stack
    }()
    
    private lazy var proteinMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minProteinDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxProteinDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()

    private lazy var fatStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Fat"))
        stack.addArrangedSubview(fatMinMaxStack)
        return stack
    }()
    
    private lazy var fatMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minFatDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxFatDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()

    private lazy var caloriesStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Calories"))
        stack.addArrangedSubview(caloriesMinMaxStack)
        return stack
    }()
    
    private lazy var caloriesMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minCaloriesDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: "800")
        maxTextField.addTarget(self, action: #selector(maxCaloriesDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    init(frame: CGRect, viewsBuilder: ParametersViewBuilder) {
        self.viewsBuilder = viewsBuilder
        super.init(frame: frame)
        setupViews()
        setupAutoLayout()
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(carbsProteinFatCaloriesGroupStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            carbsProteinFatCaloriesGroupStackView.topAnchor.constraint(equalTo: topAnchor),
            carbsProteinFatCaloriesGroupStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carbsProteinFatCaloriesGroupStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carbsProteinFatCaloriesGroupStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func minCarbsDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minCarbs = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxCarbsDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxCarbs = text.isEmpty ? max : text
        }
    }
    
    @objc private func minProteinDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minProtein = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxProteinDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxProtein = text.isEmpty ? max : text
        }
    }
    
    @objc private func minFatDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minFat = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxFatDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxFat = text.isEmpty ? max : text
        }
    }
    
    @objc private func minCaloriesDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minCalories = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxCaloriesDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxCalories = text.isEmpty ? "10000" : text
        }
    }
}
