//
//  CuisineView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class CuisineView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let viewsBuilder: ParametersViewFactory
    
    private let cuisines = ChoosingSearchParameters.cuisines
    
    var chosenCuisine = "" {
        didSet {
            chosenCuisineLabel.text = chosenCuisine
        }
    }
    
    var excludedCuisines = [String]() {
        didSet {
            if excludedCuisines.isEmpty {
                chosenExcludededCuisinesLabel.text = "Choose"
            } else {
                chosenExcludededCuisinesLabel.text = excludedCuisines.joined(separator: ", ")
            }
        }
    }
    
    var showingCuisinePicker: ((Bool) -> Void)?
    var showingExcludingCuisinesChoosing: ((MultipleChoosingViewController) -> Void)?
    
    private lazy var cuisineGroupStackView: UIStackView = {
        let stack = viewsBuilder.createVerticalStack()
        stack.addArrangedSubview(cuisineStackView)
        stack.addArrangedSubview(excludedCuisinesStackView)
        return stack
    }()

    private lazy var cuisineStackView: UIStackView = {
        let stack = viewsBuilder.createHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.createTitleLabel(text: "Cuisine"))
        stack.addArrangedSubview(chosenCuisineLabel)
        return stack
    }()

    private lazy var chosenCuisineLabel: UILabel = {
        let label = viewsBuilder.createChosenLabel(text: "Choose")
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(chooseCuisine))
        
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    private lazy var excludedCuisinesStackView: UIStackView = {
        let stack = viewsBuilder.createHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.createTitleLabel(text: "Excluded Cuisines"))
        stack.addArrangedSubview(chosenExcludededCuisinesLabel)
        return stack
    }()

    private lazy var chosenExcludededCuisinesLabel: UILabel = {
        let label = viewsBuilder.createChosenLabel(text: "Choose")
        
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
        addSubview(cuisineGroupStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            cuisineGroupStackView.topAnchor.constraint(equalTo: topAnchor),
            cuisineGroupStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cuisineGroupStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cuisineGroupStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func chooseCuisine() {
        showingCuisinePicker?(true)
    }
    
    @objc private func showMultipleChoosingController() {
        let multipleChoosingController = MultipleChoosingViewController(items: cuisines)
        
        multipleChoosingController.selectedItems = { [weak self] items in
            self?.excludedCuisines = items
        }
        
        showingExcludingCuisinesChoosing?(multipleChoosingController)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cuisines.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cuisines[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenCuisine = cuisines[row]
    }
}
