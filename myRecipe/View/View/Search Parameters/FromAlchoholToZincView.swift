//
//  FromAlchoholToZincView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.06.2021.
//

import UIKit

final class FromAlchoholToZincView: UIView {
    
    private let viewsBuilder: ParametersViewBuilder
    
    private let min = "0"
    private let max = "100"
    
    var minAlcohol = "0"
    var maxAlcohol = "100"
    var minCaffeine = "0"
    var maxCaffeine = "100"
    var minCopper = "0"
    var maxCopper = "100"
    var minCalcium = "0"
    var maxCalcium = "100"
    var minCholine = "0"
    var maxCholine = "100"
    var minCholesterol = "0"
    var maxCholesterol = "100"
    var minFluoride = "0"
    var maxFluoride = "100"
    var minSaturatedFat = "0"
    var maxSaturatedFat = "100"
    var minVitaminA = "0"
    var maxVitaminA = "100"
    var minVitaminC = "0"
    var maxVitaminC = "100"
    var minVitaminD = "0"
    var maxVitaminD = "100"
    var minVitaminE = "0"
    var maxVitaminE = "100"
    var minVitaminK = "0"
    var maxVitaminK = "100"
    var minVitaminB1 = "0"
    var maxVitaminB1 = "100"
    var minVitaminB2 = "0"
    var maxVitaminB2 = "100"
    var minVitaminB3 = "0"
    var maxVitaminB3 = "100"
    var minVitaminB5 = "0"
    var maxVitaminB5 = "100"
    var minVitaminB6 = "0"
    var maxVitaminB6 = "100"
    var minVitaminB12 = "0"
    var maxVitaminB12 = "100"
    var minFiber = "0"
    var maxFiber = "100"
    var minFolate = "0"
    var maxFolate = "100"
    var minFolicAcid = "0"
    var maxFolicAcid = "100"
    var minIodine = "0"
    var maxIodine = "100"
    var minIron = "0"
    var maxIron = "100"
    var minMagnesium = "0"
    var maxMagnesium = "100"
    var minManganese = "0"
    var maxManganese = "100"
    var minPhosphorus = "0"
    var maxPhosphorus = "100"
    var minPotassium = "0"
    var maxPotassium = "100"
    var minSelenium = "0"
    var maxSelenium = "100"
    var minSodium = "0"
    var maxSodium = "100"
    var minSugar = "0"
    var maxSugar = "100"
    var minZinc = "0"
    var maxZinc = "100"
    
    private lazy var fromAlchoholToZincGroupStackView: UIStackView = {
        let stack = viewsBuilder.buildVerticalStack()
        stack.addArrangedSubview(alcoholStackView)
        stack.addArrangedSubview(caffeineStackView)
        stack.addArrangedSubview(copperStackView)
        stack.addArrangedSubview(calciumStackView)
        stack.addArrangedSubview(cholineStackView)
        stack.addArrangedSubview(cholesterolStackView)
        stack.addArrangedSubview(fluorideStackView)
        stack.addArrangedSubview(saturatedFatStackView)
        stack.addArrangedSubview(vitaminAStackView)
        stack.addArrangedSubview(vitaminCStackView)
        stack.addArrangedSubview(vitaminDStackView)
        stack.addArrangedSubview(vitaminEStackView)
        stack.addArrangedSubview(vitaminKStackView)
        stack.addArrangedSubview(vitaminB1StackView)
        stack.addArrangedSubview(vitaminB2StackView)
        stack.addArrangedSubview(vitaminB3StackView)
        stack.addArrangedSubview(vitaminB5StackView)
        stack.addArrangedSubview(vitaminB6StackView)
        stack.addArrangedSubview(vitaminB12StackView)
        stack.addArrangedSubview(fiberStackView)
        stack.addArrangedSubview(folateStackView)
        stack.addArrangedSubview(folicAcidStackView)
        stack.addArrangedSubview(iodineStackView)
        stack.addArrangedSubview(ironStackView)
        stack.addArrangedSubview(magnesiumStackView)
        stack.addArrangedSubview(manganeseStackView)
        stack.addArrangedSubview(phosphorusStackView)
        stack.addArrangedSubview(potassiumStackView)
        stack.addArrangedSubview(seleniumStackView)
        stack.addArrangedSubview(sodiumStackView)
        stack.addArrangedSubview(sugarStackView)
        stack.addArrangedSubview(zincStackView)
        return stack
    }()
    
    private lazy var alcoholStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Aclohol"))
        stack.addArrangedSubview(alcoholMinMaxStack)
        return stack
    }()
    
    private lazy var alcoholMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minAlcoholDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxAlcoholDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var caffeineStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Caffeine"))
        stack.addArrangedSubview(caffeineMinMaxStack)
        return stack
    }()
    
    private lazy var caffeineMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minCaffeineDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxCaffeineDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var copperStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Copper"))
        stack.addArrangedSubview(copperMinMaxStack)
        return stack
    }()
    
    private lazy var copperMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minCopperDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxCopperDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var calciumStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Calcium"))
        stack.addArrangedSubview(calciumMinMaxStack)
        return stack
    }()
    
    private lazy var calciumMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minCalciumDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxCalciumDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var cholineStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Choline"))
        stack.addArrangedSubview(cholineMinMaxStack)
        return stack
    }()
    
    private lazy var cholineMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minCholineDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxCholineDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var cholesterolStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Cholesterol"))
        stack.addArrangedSubview(cholesterolMinMaxStack)
        return stack
    }()
    
    private lazy var cholesterolMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minCholesterolDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxCholesterolDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var fluorideStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Fluoride"))
        stack.addArrangedSubview(fluorideMinMaxStack)
        return stack
    }()
    
    private lazy var fluorideMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minFluorideDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxFluorideDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var saturatedFatStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Saturated Fat"))
        stack.addArrangedSubview(saturatedFatMinMaxStack)
        return stack
    }()
    
    private lazy var saturatedFatMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minSaturatedFatDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxSaturatedFatDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminAStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin A"))
        stack.addArrangedSubview(vitaminAMinMaxStack)
        return stack
    }()
    
    private lazy var vitaminAMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminADidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminADidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminCStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin C"))
        stack.addArrangedSubview(vitaminCMinMaxStack)
        return stack
    }()
    
    private lazy var vitaminCMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminCDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminCDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminDStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin D"))
        stack.addArrangedSubview(vitaminDMinMaxStack)
        return stack
    }()
    
    private lazy var vitaminDMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminDDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminDDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminEStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin E"))
        stack.addArrangedSubview(vitaminEMinMaxStack)
        return stack
    }()
    
    private lazy var vitaminEMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminEDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminEDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminKStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin K"))
        stack.addArrangedSubview(vitaminKMinMaxStack)
        return stack
    }()
    
    private lazy var vitaminKMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminKDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminKDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminB1StackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin B1"))
        stack.addArrangedSubview(vitaminB1MinMaxStack)
        return stack
    }()
    
    private lazy var vitaminB1MinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminB1DidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminB1DidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminB2StackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin B2"))
        stack.addArrangedSubview(vitaminB2MinMaxStack)
        return stack
    }()
    
    private lazy var vitaminB2MinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminB2DidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminB2DidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminB3StackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin B3"))
        stack.addArrangedSubview(vitaminB3MinMaxStack)
        return stack
    }()
    
    private lazy var vitaminB3MinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminB3DidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminB3DidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminB5StackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin B5"))
        stack.addArrangedSubview(vitaminB5MinMaxStack)
        return stack
    }()
    
    private lazy var vitaminB5MinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminB5DidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminB5DidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminB6StackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin B6"))
        stack.addArrangedSubview(vitaminB6MinMaxStack)
        return stack
    }()
    
    private lazy var vitaminB6MinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminB6DidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminB6DidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var vitaminB12StackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Vitamin B12"))
        stack.addArrangedSubview(vitaminB12MinMaxStack)
        return stack
    }()
    
    private lazy var vitaminB12MinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minVitaminB12DidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxVitaminB12DidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var fiberStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Fiber"))
        stack.addArrangedSubview(fiberMinMaxStack)
        return stack
    }()
    
    private lazy var fiberMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minFiberDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxFiberDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var folateStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Folate"))
        stack.addArrangedSubview(folateMinMaxStack)
        return stack
    }()
    
    private lazy var folateMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minFolateDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxFolateDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var folicAcidStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Folic Acid"))
        stack.addArrangedSubview(folicAcidMinMaxStack)
        return stack
    }()
    
    private lazy var folicAcidMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minFolicAcidDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxFolicAcidDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var iodineStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Iodin"))
        stack.addArrangedSubview(iodineMinMaxStack)
        return stack
    }()
    
    private lazy var iodineMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minIodineDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxIodineDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var ironStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Iron"))
        stack.addArrangedSubview(ironMinMaxStack)
        return stack
    }()
    
    private lazy var ironMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minIronDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxIronDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var magnesiumStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Magnesium"))
        stack.addArrangedSubview(magnesiumMinMaxStack)
        return stack
    }()
    
    private lazy var magnesiumMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minMagnesiumDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxMagnesiumDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var manganeseStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Manganese"))
        stack.addArrangedSubview(manganeseMinMaxStack)
        return stack
    }()
    
    private lazy var manganeseMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minManganeseDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxManganeseDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var phosphorusStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Phosphorus"))
        stack.addArrangedSubview(phosphorusMinMaxStack)
        return stack
    }()
    
    private lazy var phosphorusMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minPhosphorusDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxPhosphorusDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var potassiumStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Potassium"))
        stack.addArrangedSubview(potassiumMinMaxStack)
        return stack
    }()
    
    private lazy var potassiumMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minPotassiumDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxPotassiumDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var seleniumStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Selenium"))
        stack.addArrangedSubview(seleniumMinMaxStack)
        return stack
    }()
    
    private lazy var seleniumMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minSeleniumDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxSeleniumDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var sodiumStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Sodium"))
        stack.addArrangedSubview(sodiumMinMaxStack)
        return stack
    }()
    
    private lazy var sodiumMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minSodiumDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxSodiumDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var sugarStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Sugar"))
        stack.addArrangedSubview(sugarMinMaxStack)
        return stack
    }()
    
    private lazy var sugarMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minSugarDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxSugarDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
    }()
    
    private lazy var zincStackView: UIStackView = {
        let stack = viewsBuilder.buildHorizontalStack()
        stack.addArrangedSubview(viewsBuilder.buildTitleLabel(text: "Zinc"))
        stack.addArrangedSubview(zincMinMaxStack)
        return stack
    }()
    
    private lazy var zincMinMaxStack: UIStackView = {
        let minTextField = viewsBuilder.buildTextField(placeholder: min)
        minTextField.addTarget(self, action: #selector(minZincDidChange), for: .editingChanged)
        
        let maxTextField = viewsBuilder.buildTextField(placeholder: max)
        maxTextField.addTarget(self, action: #selector(maxZincDidChange), for: .editingChanged)
        
        return viewsBuilder.buildMinMaxStack(minTextField: minTextField, maxTextField: maxTextField)
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
    
    @objc private func minAlcoholDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minAlcohol = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxAlcoholDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxAlcohol = text.isEmpty ? min : text
        }
    }
    
    @objc private func minCaffeineDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minCaffeine = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxCaffeineDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxCaffeine = text.isEmpty ? min : text
        }
    }
    
    @objc private func minCopperDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minCopper = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxCopperDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxCopper = text.isEmpty ? min : text
        }
    }
    
    @objc private func minCalciumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minCalcium = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxCalciumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxCalcium = text.isEmpty ? min : text
        }
    }
    
    @objc private func minCholineDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minCholine = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxCholineDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxCholine = text.isEmpty ? min : text
        }
    }
    
    @objc private func minCholesterolDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minCholesterol = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxCholesterolDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxCholesterol = text.isEmpty ? min : text
        }
    }
    
    @objc private func minFluorideDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minFluoride = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxFluorideDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxFluoride = text.isEmpty ? min : text
        }
    }
    
    @objc private func minSaturatedFatDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minSaturatedFat = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxSaturatedFatDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxSaturatedFat = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminADidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminA = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminADidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminA = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminCDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminC = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminCDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminC = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminDDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminD = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminDDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminD = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminEDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminE = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminEDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminE = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminKDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminK = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminKDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminK = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminB1DidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminB1 = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminB1DidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminB1 = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminB2DidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminB2 = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminB2DidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminB2 = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminB3DidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminB3 = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminB3DidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminB3 = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminB5DidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminB5 = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminB5DidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminB5 = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminB6DidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminB6 = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminB6DidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminB6 = text.isEmpty ? min : text
        }
    }
    
    @objc private func minVitaminB12DidChange(_ textField: UITextField) {
        if let text = textField.text {
            minVitaminB12 = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxVitaminB12DidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxVitaminB12 = text.isEmpty ? min : text
        }
    }
    
    @objc private func minFiberDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minFiber = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxFiberDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxFiber = text.isEmpty ? min : text
        }
    }
    
    @objc private func minFolateDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minFolate = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxFolateDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxFolate = text.isEmpty ? min : text
        }
    }
    
    @objc private func minFolicAcidDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minFolicAcid = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxFolicAcidDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxFolicAcid = text.isEmpty ? min : text
        }
    }
    
    @objc private func minIodineDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minIodine = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxIodineDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxIodine = text.isEmpty ? min : text
        }
    }
    
    @objc private func minIronDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minIron = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxIronDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxIron = text.isEmpty ? min : text
        }
    }
    
    @objc private func minMagnesiumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minMagnesium = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxMagnesiumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxMagnesium = text.isEmpty ? min : text
        }
    }
    
    @objc private func minManganeseDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minManganese = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxManganeseDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxManganese = text.isEmpty ? min : text
        }
    }
    
    @objc private func minPhosphorusDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minPhosphorus = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxPhosphorusDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxPhosphorus = text.isEmpty ? min : text
        }
    }
    
    @objc private func minPotassiumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minPotassium = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxPotassiumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxPotassium = text.isEmpty ? min : text
        }
    }
    
    @objc private func minSeleniumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minSelenium = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxSeleniumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxSelenium = text.isEmpty ? min : text
        }
    }
    
    @objc private func minSodiumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minSodium = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxSodiumDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxSodium = text.isEmpty ? min : text
        }
    }
    
    @objc private func minSugarDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minSugar = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxSugarDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxSugar = text.isEmpty ? min : text
        }
    }
    
    @objc private func minZincDidChange(_ textField: UITextField) {
        if let text = textField.text {
            minZinc = text.isEmpty ? min : text
        }
    }
    
    @objc private func maxZincDidChange(_ textField: UITextField) {
        if let text = textField.text {
            maxZinc = text.isEmpty ? min : text
        }
    }
}
