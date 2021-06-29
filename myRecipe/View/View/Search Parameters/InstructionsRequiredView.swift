//
//  InstructionsRequiredView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class InstructionsRequiredView: UIView {

    private let viewsBuilder: SearchParametersViewsBuilder
    
    var instructionsRequired = false 
    
    private lazy var instructionsRequiredStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Instructions Required"))
        stack.addArrangedSubview(switchView)
        return stack
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        return switchView
    }()

    init(frame: CGRect, viewsBuilder: SearchParametersViewsBuilder) {
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
        addSubview(instructionsRequiredStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            instructionsRequiredStackView.topAnchor.constraint(equalTo: topAnchor),
            instructionsRequiredStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            instructionsRequiredStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            instructionsRequiredStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func switchChanged() {
        instructionsRequired = switchView.isOn
    }
}
