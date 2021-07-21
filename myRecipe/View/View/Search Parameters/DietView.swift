//
//  DietView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class DietView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let viewsFactory: ParametersViewFactory
    
    private let userDefaults = UserDefaults.standard
    
    private let diets = ChoosingSearchParameters.diets
    
    private let intolerances = ChoosingSearchParameters.intolerances
    
    var chosenDiet = "" {
        didSet {
            chosenDietLabel.text = chosenDiet
        }
    }
    
    lazy var chosenIntolerances = userDefaults.string(forKey: "Intolerances")?.components(separatedBy: ",") ?? [String]() {
        didSet {
            if chosenIntolerances.isEmpty {
                chosenIntolerancesLabel.text = "Choose"
            } else {
                chosenIntolerancesLabel.text = chosenIntolerances.joined(separator: ", ")
            }
        }
    }
    
    var showingDietPicker: ((Bool) -> Void)?
    var showingIntolerancesChoosing: ((MultipleChoosingViewController) -> Void)?
    
    private lazy var dietGroupStackView: UIStackView = {
        let stack = viewsFactory.createVerticalStack()
        stack.addArrangedSubview(dietStackView)
        stack.addArrangedSubview(intolerancesStackView)
        return stack
    }()

    private lazy var dietStackView: UIStackView = {
        let stack = viewsFactory.createHorizontalStack()
        stack.addArrangedSubview(viewsFactory.createTitleLabel(text: "Diet"))
        stack.addArrangedSubview(chosenDietLabel)
        return stack
    }()

    private lazy var chosenDietLabel: UILabel = {
        let label = viewsFactory.createChosenLabel(text: "Choose")
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(chooseDiet))
        
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    private lazy var intolerancesStackView: UIStackView = {
        let stack = viewsFactory.createHorizontalStack()
        stack.addArrangedSubview(viewsFactory.createTitleLabel(text: "Intolerances"))
        stack.addArrangedSubview(chosenIntolerancesLabel)
        return stack
    }()

    private lazy var chosenIntolerancesLabel: UILabel = {
        let label = viewsFactory.createChosenLabel(text: userDefaults.string(forKey: "Intolerances") ?? "Choose")
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(showMultipleChoosingController))
        
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
        addSubview(dietGroupStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            dietGroupStackView.topAnchor.constraint(equalTo: topAnchor),
            dietGroupStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dietGroupStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dietGroupStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func chooseDiet() {
        showingDietPicker?(true)
    }
    
    @objc private func showMultipleChoosingController() {
        let multipleChoosingController = MultipleChoosingViewController(items: intolerances)
        
        multipleChoosingController.selectedItems = { [weak self] items in
            self?.chosenIntolerances = items
        }
        
        showingIntolerancesChoosing?(multipleChoosingController)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        diets.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        diets[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenDiet = diets[row]
    }
}
