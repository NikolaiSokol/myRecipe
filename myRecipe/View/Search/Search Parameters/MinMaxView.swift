//
//  MinMaxView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 20.07.2021.
//

import UIKit

final class MinMaxView: UIView {
    
    private let viewsFactory: ParametersViewFactory
    
    private let title: String
    
    private let min = "0"
    private let max = "100"
    
    var chosenMin = "0"
    var chosenMax = "10000"
    
    private lazy var stackView: UIStackView = {
        let stack = viewsFactory.createHorizontalStack()
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(minMaxStack)
        
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textAlignment = .left
        return label
    }()
    
    private lazy var minMaxStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.axis = .horizontal
        
        stack.addArrangedSubview(minTextField)
        stack.addArrangedSubview(dashLabel)
        stack.addArrangedSubview(maxTextField)
        
        return stack
    }()
    
    private lazy var minTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = min
        textField.textAlignment = .right
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(minDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var maxTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = max
        textField.textAlignment = .right
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(maxDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var dashLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .systemGray
        return label
    }()
    
    init(frame: CGRect, viewsFactory: ParametersViewFactory, title: String) {
        self.viewsFactory = viewsFactory
        self.title = title
        super.init(frame: frame)
        setupView()
        setupAutoLayout()
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func minDidChange(_ textField: UITextField) {
        if let text = textField.text {
            chosenMin = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxDidChange(_ textField: UITextField) {
        if let text = textField.text {
            chosenMax = text.isEmpty ? min : text
        }
    }
}
