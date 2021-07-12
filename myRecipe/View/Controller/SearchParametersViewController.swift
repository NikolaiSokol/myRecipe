//
//  SearchParametersViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.06.2021.
//

import UIKit

final class SearchParametersViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    private let viewsBuilder = SearchParametersViewsBuilder()
    
    private let spacingBetweenGroups: CGFloat = 20
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Key Words
    
    private lazy var keyWordsView: KeyWordsView = {
        let view = KeyWordsView(frame: .zero, viewsBuilder: viewsBuilder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Cuisine
    private lazy var cuisineView: CuisineView = {
        let view = CuisineView(frame: .zero, viewsBuilder: viewsBuilder)
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
        let view = DietView(frame: .zero, viewsBuilder: viewsBuilder)
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
        let view = EquipmentView(frame: .zero, viewsBuilder: viewsBuilder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Ingredients
    private lazy var ingredientsView: IngredientsView = {
        let view = IngredientsView(frame: .zero, viewsBuilder: viewsBuilder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Type
    private lazy var typeView: TypeView = {
        let view = TypeView(frame: .zero, viewsBuilder: viewsBuilder)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showingTypePicker = { [weak self] _ in
            self?.addPicker(view.pickerView)
        }
        
        return view
    }()

    // MARK: - Instructions Required
    private lazy var instructionsRequiredView: InstructionsRequiredView = {
        let view = InstructionsRequiredView(frame: .zero, viewsBuilder: viewsBuilder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Max Ready Time
    private lazy var maxReadyTimeView: MaxReadyTimeView = {
        let view = MaxReadyTimeView(frame: .zero, viewsBuilder: viewsBuilder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Sort
    private lazy var sortView: SortView = {
        let view = SortView(frame: .zero, viewsBuilder: viewsBuilder)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showingSortPicker = { [weak self] _ in
            self?.addPicker(view.pickerView)
        }
        
        return view
    }()

    // MARK: - Carbs, Protein, Fat, Calories
    private lazy var carbsProteinFatCaloriesView: CarbsProteinFatCaloriesView = {
        let view = CarbsProteinFatCaloriesView(frame: .zero, viewsBuilder: viewsBuilder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - From Alchohol to Zinc
    private lazy var fromAlchoholToZincView: FromAlchoholToZincView = {
        let view = FromAlchoholToZincView(frame: .zero, viewsBuilder: viewsBuilder)
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
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
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
            minCarbs: carbsProteinFatCaloriesView.minCarbs,
            maxCarbs: carbsProteinFatCaloriesView.maxCarbs,
            minProtein: carbsProteinFatCaloriesView.minProtein,
            maxProtein: carbsProteinFatCaloriesView.maxProtein,
            minCalories: carbsProteinFatCaloriesView.minCalories,
            maxCalories: carbsProteinFatCaloriesView.maxCalories,
            minFat: carbsProteinFatCaloriesView.minFat,
            maxFat: carbsProteinFatCaloriesView.maxFat,
            minAlcohol: fromAlchoholToZincView.minAlcohol,
            maxAlcohol: fromAlchoholToZincView.maxAlcohol,
            minCaffeine: fromAlchoholToZincView.minCaffeine,
            maxCaffeine: fromAlchoholToZincView.maxCaffeine,
            minCopper: fromAlchoholToZincView.minCopper,
            maxCopper: fromAlchoholToZincView.maxCopper,
            minCalcium: fromAlchoholToZincView.minCalcium,
            maxCalcium: fromAlchoholToZincView.maxCalcium,
            minCholine: fromAlchoholToZincView.minCholine,
            maxCholine: fromAlchoholToZincView.maxCholine,
            minCholesterol: fromAlchoholToZincView.minCholesterol,
            maxCholesterol: fromAlchoholToZincView.maxCholesterol,
            minFluoride: fromAlchoholToZincView.minFluoride,
            maxFluoride: fromAlchoholToZincView.maxFluoride,
            minSaturatedFat: fromAlchoholToZincView.minSaturatedFat,
            maxSaturatedFat: fromAlchoholToZincView.maxSaturatedFat,
            minVitaminA: fromAlchoholToZincView.minVitaminA,
            maxVitaminA: fromAlchoholToZincView.maxVitaminA,
            minVitaminC: fromAlchoholToZincView.minVitaminC,
            maxVitaminC: fromAlchoholToZincView.maxVitaminC,
            minVitaminD: fromAlchoholToZincView.minVitaminD,
            maxVitaminD: fromAlchoholToZincView.maxVitaminD,
            minVitaminE: fromAlchoholToZincView.minVitaminE,
            maxVitaminE: fromAlchoholToZincView.maxVitaminE,
            minVitaminK: fromAlchoholToZincView.minVitaminK,
            maxVitaminK: fromAlchoholToZincView.maxVitaminK,
            minVitaminB1: fromAlchoholToZincView.minVitaminB1,
            maxVitaminB1: fromAlchoholToZincView.maxVitaminB1,
            minVitaminB2: fromAlchoholToZincView.minVitaminB2,
            maxVitaminB2: fromAlchoholToZincView.maxVitaminB2,
            minVitaminB3: fromAlchoholToZincView.minVitaminB3,
            maxVitaminB3: fromAlchoholToZincView.maxVitaminB3,
            minVitaminB5: fromAlchoholToZincView.minVitaminB5,
            maxVitaminB5: fromAlchoholToZincView.maxVitaminB5,
            minVitaminB6: fromAlchoholToZincView.minVitaminB6,
            maxVitaminB6: fromAlchoholToZincView.maxVitaminB6,
            minVitaminB12: fromAlchoholToZincView.minVitaminB12,
            maxVitaminB12: fromAlchoholToZincView.maxVitaminB12,
            minFiber: fromAlchoholToZincView.minFiber,
            maxFiber: fromAlchoholToZincView.maxFiber,
            minFolate: fromAlchoholToZincView.minFolate,
            maxFolate: fromAlchoholToZincView.maxFolate,
            minFolicAcid: fromAlchoholToZincView.minFolicAcid,
            maxFolicAcid: fromAlchoholToZincView.maxFolicAcid,
            minIodine: fromAlchoholToZincView.minIodine,
            maxIodine: fromAlchoholToZincView.maxIodine,
            minIron: fromAlchoholToZincView.minIron,
            maxIron: fromAlchoholToZincView.maxIron,
            minMagnesium: fromAlchoholToZincView.minMagnesium,
            maxMagnesium: fromAlchoholToZincView.maxMagnesium,
            minManganese: fromAlchoholToZincView.minManganese,
            maxManganese: fromAlchoholToZincView.maxManganese,
            minPhosphorus: fromAlchoholToZincView.minPhosphorus,
            maxPhosphorus: fromAlchoholToZincView.maxPhosphorus,
            minPotassium: fromAlchoholToZincView.minPotassium,
            maxPotassium: fromAlchoholToZincView.maxPotassium,
            minSelenium: fromAlchoholToZincView.minSelenium,
            maxSelenium: fromAlchoholToZincView.maxSelenium,
            minSodium: fromAlchoholToZincView.minSodium,
            maxSodium: fromAlchoholToZincView.maxSodium,
            minSugar: fromAlchoholToZincView.minSugar,
            maxSugar: fromAlchoholToZincView.maxSugar,
            minZinc: fromAlchoholToZincView.minZinc,
            maxZinc: fromAlchoholToZincView.maxZinc
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
