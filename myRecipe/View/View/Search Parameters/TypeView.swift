//
//  TypeView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class TypeView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    private let viewsBuilder: SearchParametersViewsBuilder
    
    private let types = [
        "Main course",
        "Side dish",
        "Dessert",
        "Appetizer",
        "Salad",
        "Bread",
        "Breakfast",
        "Soup",
        "Beverage",
        "Sauce",
        "Marinade",
        "Fingerfood",
        "Snack",
        "Drink"
    ]
    
    var chosenType = "" {
        didSet {
            chosenTypeLabel.text = chosenType
        }
    }
    
    var showingTypePicker: ((Bool) -> Void)?
    
    private lazy var typeStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Type"))
        stack.addArrangedSubview(chosenTypeLabel)
        return stack
    }()

    private lazy var chosenTypeLabel: UILabel = {
        let label = viewsBuilder.buildChosenLabel(text: "Choose")
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(chooseType))
        
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private(set) lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
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
        addSubview(typeStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            typeStackView.topAnchor.constraint(equalTo: topAnchor),
            typeStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            typeStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            typeStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func chooseType() {
        showingTypePicker?(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        types.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenType = types[row]
    }
}
