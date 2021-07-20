//
//  CarbsProteinFatCaloriesView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class CarbsProteinFatCaloriesView: UIView {

    private let factory: MinMaxViewFactory
    
    private lazy var carbsProteinFatCaloriesGroupStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 1
        
        stack.addArrangedSubview(carbsView)
        stack.addArrangedSubview(proteinView)
        stack.addArrangedSubview(fatView)
        stack.addArrangedSubview(caloriesView)
        
        return stack
    }()
    
    private(set) lazy var carbsView: MinMaxView = {
        factory.create(title: "Carbs")
    }()
    
    private(set) lazy var proteinView: MinMaxView = {
        factory.create(title: "Protein")
    }()
    
    private(set) lazy var fatView: MinMaxView = {
        factory.create(title: "Fat")
    }()
    
    private(set) lazy var caloriesView: MinMaxView = {
        factory.create(title: "Calories")
    }()
    
    init(frame: CGRect, factory: MinMaxViewFactory) {
        self.factory = factory
        super.init(frame: frame)
        setupViews()
        setupAutoLayout()
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(carbsProteinFatCaloriesGroupStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            carbsProteinFatCaloriesGroupStackView.topAnchor.constraint(equalTo: topAnchor),
            carbsProteinFatCaloriesGroupStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carbsProteinFatCaloriesGroupStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carbsProteinFatCaloriesGroupStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
