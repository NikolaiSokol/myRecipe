//
//  EquipmentView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class EquipmentView: UIView {
    
    private let viewsBuilder: ParametersViewBuilder
    
    var equipment = ""
    
    private lazy var equipmentStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Equipment"))
        stack.addArrangedSubview(equipmentTextField)
        return stack
    }()
    
    private lazy var equipmentTextField: UITextField = {
        let textField = viewsBuilder.buildTextField(placeholder: "blender, frying pan, bowl")
        textField.addTarget(self, action: #selector(equipmentDidChange), for: .editingChanged)
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
