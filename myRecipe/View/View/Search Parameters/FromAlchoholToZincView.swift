//
//  FromAlchoholToZincView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class FromAlchoholToZincView: UIView {
    
    private let parametersViewFactory: ParametersViewFactory
    private let minMaxViewfactory: MinMaxViewFactory
    
    private lazy var fromAlchoholToZincGroupStackView: UIStackView = {
        let stack = parametersViewFactory.createVerticalStack()
        
        stack.addArrangedSubview(alcoholView)
        stack.addArrangedSubview(caffeineView)
        stack.addArrangedSubview(copperView)
        stack.addArrangedSubview(calciumView)
        stack.addArrangedSubview(cholineView)
        stack.addArrangedSubview(cholesterolView)
        stack.addArrangedSubview(fluorideView)
        stack.addArrangedSubview(saturatedFatView)
        stack.addArrangedSubview(vitaminAView)
        stack.addArrangedSubview(vitaminCView)
        stack.addArrangedSubview(vitaminDView)
        stack.addArrangedSubview(vitaminEView)
        stack.addArrangedSubview(vitaminKView)
        stack.addArrangedSubview(vitaminB1View)
        stack.addArrangedSubview(vitaminB2View)
        stack.addArrangedSubview(vitaminB3View)
        stack.addArrangedSubview(vitaminB5View)
        stack.addArrangedSubview(vitaminB6View)
        stack.addArrangedSubview(vitaminB12View)
        stack.addArrangedSubview(fiberView)
        stack.addArrangedSubview(folateView)
        stack.addArrangedSubview(folicAcidView)
        stack.addArrangedSubview(iodineView)
        stack.addArrangedSubview(ironView)
        stack.addArrangedSubview(magnesiumView)
        stack.addArrangedSubview(manganeseView)
        stack.addArrangedSubview(phosphorusView)
        stack.addArrangedSubview(potassiumView)
        stack.addArrangedSubview(seleniumView)
        stack.addArrangedSubview(sodiumView)
        stack.addArrangedSubview(sugarView)
        stack.addArrangedSubview(zincView)
        
        return stack
    }()
    
    private(set) lazy var alcoholView: MinMaxView = {
        minMaxViewfactory.create(title: "Alchohol")
    }()
    
    private(set) lazy var caffeineView: MinMaxView = {
        minMaxViewfactory.create(title: "Caffeine")
    }()
    
    private(set) lazy var copperView: MinMaxView = {
        minMaxViewfactory.create(title: "Copper")
    }()
    
    private(set) lazy var calciumView: MinMaxView = {
        minMaxViewfactory.create(title: "Calcium")
    }()
    
    private(set) lazy var cholineView: MinMaxView = {
        minMaxViewfactory.create(title: "Choline")
    }()
    
    private(set) lazy var cholesterolView: MinMaxView = {
        minMaxViewfactory.create(title: "Cholesterol")
    }()
    
    private(set) lazy var fluorideView: MinMaxView = {
        minMaxViewfactory.create(title: "Fluoride")
    }()
    
    private(set) lazy var saturatedFatView: MinMaxView = {
        minMaxViewfactory.create(title: "Saturated Fat")
    }()
    
    private(set) lazy var vitaminAView: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin A")
    }()
    
    private(set) lazy var vitaminCView: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin C")
    }()
    
    private(set) lazy var vitaminDView: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin D")
    }()
    
    private(set) lazy var vitaminEView: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin E")
    }()
    
    private(set) lazy var vitaminKView: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin K")
    }()
    
    private(set) lazy var vitaminB1View: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin B1")
    }()
    
    private(set) lazy var vitaminB2View: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin B2")
    }()
    
    private(set) lazy var vitaminB3View: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin B3")
    }()
    
    private(set) lazy var vitaminB5View: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin B5")
    }()
    
    private(set) lazy var vitaminB6View: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin B6")
    }()
    
    private(set) lazy var vitaminB12View: MinMaxView = {
        minMaxViewfactory.create(title: "Vitamin B12")
    }()
    
    private(set) lazy var fiberView: MinMaxView = {
        minMaxViewfactory.create(title: "Fiber")
    }()
    
    private(set) lazy var folateView: MinMaxView = {
        minMaxViewfactory.create(title: "Folate")
    }()
    
    private(set) lazy var folicAcidView: MinMaxView = {
        minMaxViewfactory.create(title: "Folic Acid")
    }()
    
    private(set) lazy var iodineView: MinMaxView = {
        minMaxViewfactory.create(title: "Iodin")
    }()
    
    private(set) lazy var ironView: MinMaxView = {
        minMaxViewfactory.create(title: "Iron")
    }()
    
    private(set) lazy var magnesiumView: MinMaxView = {
        minMaxViewfactory.create(title: "Magnesium")
    }()
    
    private(set) lazy var manganeseView: MinMaxView = {
        minMaxViewfactory.create(title: "Manganese")
    }()
    
    private(set) lazy var phosphorusView: MinMaxView = {
        minMaxViewfactory.create(title: "Phosphorus")
    }()
    
    private(set) lazy var potassiumView: MinMaxView = {
        minMaxViewfactory.create(title: "Potassium")
    }()
    
    private(set) lazy var seleniumView: MinMaxView = {
        minMaxViewfactory.create(title: "Selenium")
    }()
    
    private(set) lazy var sodiumView: MinMaxView = {
        minMaxViewfactory.create(title: "Sodium")
    }()
    
    private(set) lazy var sugarView: MinMaxView = {
        minMaxViewfactory.create(title: "Sugar")
    }()
    
    private(set) lazy var zincView: MinMaxView = {
        minMaxViewfactory.create(title: "Zinc")
    }()
    
    init(frame: CGRect, parametersViewFactory: ParametersViewFactory, minMaxViewfactory: MinMaxViewFactory) {
        self.parametersViewFactory = parametersViewFactory
        self.minMaxViewfactory = minMaxViewfactory
        super.init(frame: frame)
        setupViews()
        setupAutoLayout()
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(fromAlchoholToZincGroupStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            fromAlchoholToZincGroupStackView.topAnchor.constraint(equalTo: topAnchor),
            fromAlchoholToZincGroupStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fromAlchoholToZincGroupStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fromAlchoholToZincGroupStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
