//
//  KeyWordsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class KeyWordsView: UIView {
    
    private let viewsFactory: ParametersViewFactory
    
    var keyWords = ""
    
    private lazy var keyWordsStackView: UIStackView = {
        let stack = viewsFactory.createHorizontalStack()
        stack.addArrangedSubview(viewsFactory.createTitleLabel(text: "Key words"))
        stack.addArrangedSubview(keyWordsTextField)
        return stack
    }()
    
    private lazy var keyWordsTextField: UITextField = {
        let textField = viewsFactory.createTextField(placeholder: "pasta with tomatoes")
        textField.addTarget(self, action: #selector(keyWordsDidChange), for: .editingChanged)
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
