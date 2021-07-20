//
//  KeyWordsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class KeyWordsView: UIView {
    
    private let viewsBuilder: ParametersViewFactory
    
    var keyWords = ""
    
    private lazy var keyWordsStackView: UIStackView = {
        let stack = viewsBuilder.createHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.createTitleLabel(text: "Key words"))
        stack.addArrangedSubview(keyWordsTextField)
        return stack
    }()
    
    private lazy var keyWordsTextField: UITextField = {
        let textField = viewsBuilder.createTextField(placeholder: "pasta with tomatoes")
        textField.addTarget(self, action: #selector(keyWordsDidChange), for: .editingChanged)
        return textField
    }()
    
    init(frame: CGRect, viewsBuilder: ParametersViewFactory) {
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
        addSubview(keyWordsStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            keyWordsStackView.topAnchor.constraint(equalTo: topAnchor),
            keyWordsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            keyWordsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            keyWordsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func keyWordsDidChange(_ textField: UITextField) {
        if let text = textField.text {
            keyWords = text
        }
    }
}
