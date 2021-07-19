//
//  MaxReadyTimeView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class MaxReadyTimeView: UIView {
    
    private let viewsBuilder: ParametersViewBuilder
    
    var maxReadyTime = "60"
    
    private lazy var maxReadyTimeStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Max. Ready Time, minutes"))
        stack.addArrangedSubview(maxReadyTimeTextField)
        return stack
    }()
    
    private lazy var maxReadyTimeTextField: UITextField = {
        let textField = viewsBuilder.buildTextField(placeholder: "20")
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(maxReadyTimeDidChange), for: .editingChanged)
        return textField
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
        addSubview(maxReadyTimeStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            maxReadyTimeStackView.topAnchor.constraint(equalTo: topAnchor),
            maxReadyTimeStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            maxReadyTimeStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            maxReadyTimeStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func maxReadyTimeDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxReadyTime = text.isEmpty ? "60" : text
        }
    }
}
