//
//  SortView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class SortView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    private let viewsBuilder: SearchParametersViewsBuilder
    
    private let sorts = [
        "meta-score",
        "popularity",
        "healthiness",
        "price",
        "time",
        "random",
        "max-used-ingredients",
        "min-missing-ingredients",
        "alcohol",
        "caffeine",
        "copper",
        "energy",
        "calories",
        "calcium",
        "carbohydrates",
        "carbs",
        "choline",
        "cholesterol",
        "total-fat",
        "fluoride",
        "trans-fat",
        "saturated-fat",
        "mono-unsaturated-fat",
        "poly-unsaturated-fat",
        "fiber",
        "folate",
        "folic-acid",
        "iodine",
        "iron",
        "magnesium",
        "manganese",
        "vitamin-b3",
        "niacin",
        "vitamin-b5",
        "pantothenic-acid",
        "phosphorus",
        "potassium",
        "protein",
        "vitamin-b2",
        "riboflavin",
        "selenium",
        "sodium",
        "vitamin-b1",
        "thiamin",
        "vitamin-a",
        "vitamin-b6",
        "vitamin-b12",
        "vitamin-c",
        "vitamin-d",
        "vitamin-e",
        "vitamin-k",
        "sugar",
        "zinc"
    ]
    
    var chosenSort = "" {
        didSet {
            chosenSortLabel.text = chosenSort
        }
    }
    
    var chosenSortDirection = "asc"
    
    var showingSortPicker: ((Bool) -> Void)?
    
    private lazy var sortGroupStackView: UIStackView = {
        let stack = viewsBuilder.buildVerticalStack()
        stack.addArrangedSubview(sortStackView)
        stack.addArrangedSubview(sortDirectionStackView)
        return stack
    }()

    private lazy var sortStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Sorted by"))
        stack.addArrangedSubview(chosenSortLabel)
        return stack
    }()

    private lazy var chosenSortLabel: UILabel = {
        let label = viewsBuilder.buildChosenLabel(text: "Choose")
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(chooseSort))
        
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    private lazy var sortDirectionStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Sort Direction"))
        stack.addArrangedSubview(sortDirectionSegmentedControl)
        return stack
    }()

    private lazy var sortDirectionSegmentedControl: UISegmentedControl = {
        let items = ["Ascending", "Descending"]
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
        return segmentedControl
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
        addSubview(sortGroupStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            sortGroupStackView.topAnchor.constraint(equalTo: topAnchor),
            sortGroupStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sortGroupStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sortGroupStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func chooseSort() {
        showingSortPicker?(true)
    }
    
    @objc private func segmentedControlDidChange() {
        if sortDirectionSegmentedControl.selectedSegmentIndex == 0 {
            chosenSortDirection = "asc"
        } else {
            chosenSortDirection = "desc"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sorts.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        sorts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenSort = sorts[row]
    }
}
