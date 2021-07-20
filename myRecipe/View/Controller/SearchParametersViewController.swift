//
//  SearchParametersViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.06.2021.
//

import UIKit

final class SearchParametersViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    private let parametersViewFactory: ParametersViewFactory
    private lazy var minMaxViewfactory = MinMaxViewFactory(parametersViewFactory: parametersViewFactory)
    
    private let spacingBetweenGroups: CGFloat = 20
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Key Words
    
    private lazy var keyWordsView: KeyWordsView = {
        let view = KeyWordsView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Cuisine
    private lazy var cuisineView: CuisineView = {
        let view = CuisineView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showingCuisinePicker = { [weak self] _ in
            self?.addPicker(view.pickerView)
        }
        
        view.showingExcludingCuisinesChoosing = { [weak self] controller in
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        
        return view
    }()

    // MARK: - Diet and Intolerances
    private lazy var dietView: DietView = {
        let view = DietView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showingDietPicker = { [weak self] _ in
            self?.addPicker(view.pickerView)
        }
        
        view.showingIntolerancesChoosing = { [weak self] controller in
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        
        return view
    }()

    // MARK: - Equipment
    private lazy var equipmentView: EquipmentView = {
        let view = EquipmentView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Ingredients
    private lazy var ingredientsView: IngredientsView = {
        let view = IngredientsView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Type
    private lazy var typeView: TypeView = {
        let view = TypeView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showingTypePicker = { [weak self] _ in
            self?.addPicker(view.pickerView)
        }
        
        return view
    }()

    // MARK: - Instructions Required
    private lazy var instructionsRequiredView: InstructionsRequiredView = {
        let view = InstructionsRequiredView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Max Ready Time
    private lazy var maxReadyTimeView: MaxReadyTimeView = {
        let view = MaxReadyTimeView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Sort
    private lazy var sortView: SortView = {
        let view = SortView(frame: .zero, viewsBuilder: parametersViewFactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showingSortPicker = { [weak self] _ in
            self?.addPicker(view.pickerView)
        }
        
        return view
    }()

    // MARK: - Carbs, Protein, Fat, Calories
    private lazy var carbsProteinFatCaloriesView: CarbsProteinFatCaloriesView = {
        let view = CarbsProteinFatCaloriesView(frame: .zero, factory: minMaxViewfactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - From Alchohol to Zinc
    private lazy var fromAlchoholToZincView: FromAlchoholToZincView = {
        let view = FromAlchoholToZincView(frame: .zero, parametersViewFactory: parametersViewFactory, minMaxViewfactory: minMaxViewfactory)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        button.setTitle("Search", for: .normal)
        button.tintColor = UIColor(named: "buttonTint")
        button.backgroundColor = UIColor(named: "cell")
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        return button
    }()
    
    private lazy var pickerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "background")
        view.isHidden = true
        return view
    }()
    
    private lazy var pickerDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(pickerDoneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pickerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: SearchViewModel, parametersViewFactory: ParametersViewFactory) {
        self.viewModel = viewModel
        self.parametersViewFactory = parametersViewFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAutoLayout()
    }
    
    private func setupViews() {
        title = "Search with parameters"
        view.backgroundColor = UIColor(named: "background")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Search", style: .done, target: self, action: #selector(search)
        )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
        
        view.addSubview(scrollView)
        
        view.addSubview(pickerContainerView)
        pickerContainerView.addSubview(pickerDoneButton)
        pickerContainerView.addSubview(pickerView)
        
        scrollView.addSubview(keyWordsView)
        scrollView.addSubview(cuisineView)
        scrollView.addSubview(dietView)
        scrollView.addSubview(equipmentView)
        scrollView.addSubview(ingredientsView)
        scrollView.addSubview(typeView)
        scrollView.addSubview(instructionsRequiredView)
        scrollView.addSubview(maxReadyTimeView)
        scrollView.addSubview(sortView)
        scrollView.addSubview(carbsProteinFatCaloriesView)
        scrollView.addSubview(fromAlchoholToZincView)
        scrollView.addSubview(searchButton)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            pickerDoneButton.topAnchor.constraint(equalTo: pickerContainerView.topAnchor),
            pickerDoneButton.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor, constant: -20),
            
            pickerView.topAnchor.constraint(equalTo: pickerDoneButton.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: pickerContainerView.bottomAnchor),
            
            pickerContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pickerContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            keyWordsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacingBetweenGroups),
            keyWordsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            keyWordsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            cuisineView.topAnchor.constraint(equalTo: keyWordsView.bottomAnchor, constant: spacingBetweenGroups),
            cuisineView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cuisineView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            dietView.topAnchor.constraint(equalTo: cuisineView.bottomAnchor, constant: spacingBetweenGroups),
            dietView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dietView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            equipmentView.topAnchor.constraint(equalTo: dietView.bottomAnchor, constant: spacingBetweenGroups),
            equipmentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            equipmentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            ingredientsView.topAnchor.constraint(equalTo: equipmentView.bottomAnchor, constant: spacingBetweenGroups),
            ingredientsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            ingredientsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            typeView.topAnchor.constraint(equalTo: ingredientsView.bottomAnchor, constant: spacingBetweenGroups),
            typeView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            typeView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            instructionsRequiredView.topAnchor.constraint(equalTo: typeView.bottomAnchor, constant: spacingBetweenGroups),
            instructionsRequiredView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            instructionsRequiredView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            maxReadyTimeView.topAnchor.constraint(equalTo: instructionsRequiredView.bottomAnchor, constant: spacingBetweenGroups),
            maxReadyTimeView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            maxReadyTimeView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            sortView.topAnchor.constraint(equalTo: maxReadyTimeView.bottomAnchor, constant: spacingBetweenGroups),
            sortView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            sortView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            carbsProteinFatCaloriesView.topAnchor.constraint(equalTo: sortView.bottomAnchor, constant: spacingBetweenGroups),
            carbsProteinFatCaloriesView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            carbsProteinFatCaloriesView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            fromAlchoholToZincView.topAnchor.constraint(equalTo: carbsProteinFatCaloriesView.bottomAnchor, constant: spacingBetweenGroups),
            fromAlchoholToZincView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            fromAlchoholToZincView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            searchButton.topAnchor.constraint(equalTo: fromAlchoholToZincView.bottomAnchor, constant: spacingBetweenGroups),
            searchButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            searchButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            searchButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -spacingBetweenGroups)
        ])
    }
    
    @objc private func tapGesture() {
        view.endEditing(true)
        pickerContainerView.isHidden = true
    }
    
    @objc private func search() {
        let searchParameters = RecipesSearchParameters(
            query: keyWordsView.keyWords.lowercased(),
            cuisine: cuisineView.chosenCuisine.lowercased(),
            excludeCuisine: cuisineView.excludedCuisines.joined(separator: ", ").lowercased(),
            diet: dietView.chosenDiet.lowercased(),
            intolerances: dietView.chosenIntolerances.joined(separator: ", ").lowercased(),
            equipment: equipmentView.equipment.lowercased(),
            includeIngredients: ingredientsView.includedIngredients.lowercased(),
            excludeIngredients: ingredientsView.excludedIngredients.lowercased(),
            type: typeView.chosenType.lowercased(),
            instructionsRequired: String(instructionsRequiredView.instructionsRequired),
            maxReadyTime: maxReadyTimeView.maxReadyTime,
            sort: sortView.chosenSort,
            sortDirection: sortView.chosenSortDirection,
            minCarbs: carbsProteinFatCaloriesView.carbsView.chosenMin,
            maxCarbs: carbsProteinFatCaloriesView.carbsView.chosenMax,
            minProtein: carbsProteinFatCaloriesView.proteinView.chosenMin,
            maxProtein: carbsProteinFatCaloriesView.proteinView.chosenMax,
            minCalories: carbsProteinFatCaloriesView.caloriesView.chosenMin,
            maxCalories: carbsProteinFatCaloriesView.caloriesView.chosenMax,
            minFat: carbsProteinFatCaloriesView.fatView.chosenMin,
            maxFat: carbsProteinFatCaloriesView.fatView.chosenMax,
            minAlcohol: fromAlchoholToZincView.alcoholView.chosenMin,
            maxAlcohol: fromAlchoholToZincView.alcoholView.chosenMax,
            minCaffeine: fromAlchoholToZincView.caffeineView.chosenMin,
            maxCaffeine: fromAlchoholToZincView.caffeineView.chosenMax,
            minCopper: fromAlchoholToZincView.copperView.chosenMin,
            maxCopper: fromAlchoholToZincView.copperView.chosenMax,
            minCalcium: fromAlchoholToZincView.calciumView.chosenMin,
            maxCalcium: fromAlchoholToZincView.calciumView.chosenMax,
            minCholine: fromAlchoholToZincView.cholineView.chosenMin,
            maxCholine: fromAlchoholToZincView.cholineView.chosenMax,
            minCholesterol: fromAlchoholToZincView.cholesterolView.chosenMin,
            maxCholesterol: fromAlchoholToZincView.cholesterolView.chosenMax,
            minFluoride: fromAlchoholToZincView.fluorideView.chosenMin,
            maxFluoride: fromAlchoholToZincView.fluorideView.chosenMax,
            minSaturatedFat: fromAlchoholToZincView.saturatedFatView.chosenMin,
            maxSaturatedFat: fromAlchoholToZincView.saturatedFatView.chosenMax,
            minVitaminA: fromAlchoholToZincView.vitaminAView.chosenMin,
            maxVitaminA: fromAlchoholToZincView.vitaminAView.chosenMax,
            minVitaminC: fromAlchoholToZincView.vitaminCView.chosenMin,
            maxVitaminC: fromAlchoholToZincView.vitaminCView.chosenMax,
            minVitaminD: fromAlchoholToZincView.vitaminDView.chosenMin,
            maxVitaminD: fromAlchoholToZincView.vitaminDView.chosenMax,
            minVitaminE: fromAlchoholToZincView.vitaminEView.chosenMin,
            maxVitaminE: fromAlchoholToZincView.vitaminEView.chosenMax,
            minVitaminK: fromAlchoholToZincView.vitaminKView.chosenMin,
            maxVitaminK: fromAlchoholToZincView.vitaminKView.chosenMax,
            minVitaminB1: fromAlchoholToZincView.vitaminB1View.chosenMin,
            maxVitaminB1: fromAlchoholToZincView.vitaminB1View.chosenMax,
            minVitaminB2: fromAlchoholToZincView.vitaminB2View.chosenMin,
            maxVitaminB2: fromAlchoholToZincView.vitaminB2View.chosenMax,
            minVitaminB3: fromAlchoholToZincView.vitaminB3View.chosenMin,
            maxVitaminB3: fromAlchoholToZincView.vitaminB3View.chosenMax,
            minVitaminB5: fromAlchoholToZincView.vitaminB5View.chosenMin,
            maxVitaminB5: fromAlchoholToZincView.vitaminB5View.chosenMax,
            minVitaminB6: fromAlchoholToZincView.vitaminB6View.chosenMin,
            maxVitaminB6: fromAlchoholToZincView.vitaminB6View.chosenMax,
            minVitaminB12: fromAlchoholToZincView.vitaminB12View.chosenMin,
            maxVitaminB12: fromAlchoholToZincView.vitaminB12View.chosenMax,
            minFiber: fromAlchoholToZincView.fiberView.chosenMin,
            maxFiber: fromAlchoholToZincView.fiberView.chosenMax,
            minFolate: fromAlchoholToZincView.folateView.chosenMin,
            maxFolate: fromAlchoholToZincView.folateView.chosenMax,
            minFolicAcid: fromAlchoholToZincView.folicAcidView.chosenMin,
            maxFolicAcid: fromAlchoholToZincView.folicAcidView.chosenMax,
            minIodine: fromAlchoholToZincView.iodineView.chosenMin,
            maxIodine: fromAlchoholToZincView.iodineView.chosenMax,
            minIron: fromAlchoholToZincView.ironView.chosenMin,
            maxIron: fromAlchoholToZincView.ironView.chosenMax,
            minMagnesium: fromAlchoholToZincView.magnesiumView.chosenMin,
            maxMagnesium: fromAlchoholToZincView.magnesiumView.chosenMax,
            minManganese: fromAlchoholToZincView.manganeseView.chosenMin,
            maxManganese: fromAlchoholToZincView.manganeseView.chosenMax,
            minPhosphorus: fromAlchoholToZincView.phosphorusView.chosenMin,
            maxPhosphorus: fromAlchoholToZincView.phosphorusView.chosenMax,
            minPotassium: fromAlchoholToZincView.potassiumView.chosenMin,
            maxPotassium: fromAlchoholToZincView.potassiumView.chosenMax,
            minSelenium: fromAlchoholToZincView.seleniumView.chosenMin,
            maxSelenium: fromAlchoholToZincView.seleniumView.chosenMax,
            minSodium: fromAlchoholToZincView.sodiumView.chosenMin,
            maxSodium: fromAlchoholToZincView.sodiumView.chosenMax,
            minSugar: fromAlchoholToZincView.sugarView.chosenMin,
            maxSugar: fromAlchoholToZincView.sugarView.chosenMax,
            minZinc: fromAlchoholToZincView.zincView.chosenMin,
            maxZinc: fromAlchoholToZincView.zincView.chosenMax
        )
        
        navigationController?.popViewController(animated: true)
        
        viewModel.recipes.removeAll()
        viewModel.setSearchParameters(searchParameters)
    }
    
    @objc private func pickerDoneButtonTapped() {
        pickerContainerView.isHidden = true
    }
    
    private func addPicker(_ picker: UIPickerView) {
        pickerView.subviews.forEach { $0.removeFromSuperview() }
        pickerView.addSubview(picker)
        
        NSLayoutConstraint.activate([
            
            picker.topAnchor.constraint(equalTo: pickerDoneButton.bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: pickerView.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: pickerView.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: pickerView.bottomAnchor)
        ])
        
        pickerContainerView.isHidden = false
    }
}
