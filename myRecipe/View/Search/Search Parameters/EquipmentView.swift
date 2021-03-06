//
//  EquipmentView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class EquipmentView: UIView {
    
    private let viewsFactory: ParametersViewFactory
    
    var equipment = ""
    
    private lazy var equipmentStackView: UIStackView = {
        let stack = viewsFactory.createHorizontalStack()
        stack.addArrangedSubview(viewsFactory.createTitleLabel(text: "Equipment"))
        stack.addArrangedSubview(equipmentTextField)
        return stack
    }()
    
    private lazy var equipmentTextField: UITextField = {
        let textField = viewsFactory.createTextField(placeholder: "blender, frying pan, bowl")
        textField.addTarget(self, action: #selector(equipmentDidChange), for: .editingChanged)
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
        addSubview(equipmentStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            equipmentStackView.topAnchor.constraint(equalTo: topAnchor),
            equipmentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            equipmentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            equipmentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func equipmentDidChange(_ textField: UITextField) {
        if let text = textField.text {
            equipment = text
        }
    }
}
