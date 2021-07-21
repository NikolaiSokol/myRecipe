//
//  RecipeViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 04.07.2021.
//

import UIKit

final class RecipeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let viewModel: RecipeViewModel
    private let loadingScreen = LoadingScreenViewController()
    
    private lazy var saveRecipeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveRecipe), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteRecipeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(deleteRecipe), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var recipeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor(named: "cell")
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        stack.addArrangedSubview(recipeImageView)
        stack.addArrangedSubview(recipeTitleLabel)
        stack.addArrangedSubview(shortInfoStack)
        stack.addArrangedSubview(extendedIngredientsTitleLabel)
        stack.addArrangedSubview(measuresSegmentedControl)
        stack.addArrangedSubview(extendedIngredientsCollectionView)
        stack.addArrangedSubview(instructionsTitleLabel)
        stack.addArrangedSubview(instructionsLabel)
        stack.addArrangedSubview(recipeSourceButton)
        
        return stack
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var shortInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = UIColor(named: "background")
        stack.axis = .vertical
        stack.spacing = 5
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.layer.cornerRadius = 10
        
        stack.addArrangedSubview(readyTimeLabel)
        stack.addArrangedSubview(servingsLabel)
        stack.addArrangedSubview(weightPerServingsLabel)
        stack.addArrangedSubview(bestForLabel)
        stack.addArrangedSubview(caloriesLabel)
        stack.addArrangedSubview(proteinLabel)
        stack.addArrangedSubview(fatLabel)
        stack.addArrangedSubview(carbsLabel)
        stack.addArrangedSubview(nutrientsButton)
        
        return stack
    }()
    
    private lazy var readyTimeLabel: UILabel = {
        makeShortInfoLabel()
    }()
    
    private lazy var servingsLabel: UILabel = {
        makeShortInfoLabel()
    }()
    
    private lazy var weightPerServingsLabel: UILabel = {
        makeShortInfoLabel()
    }()
    
    private lazy var bestForLabel: UILabel = {
        makeShortInfoLabel()
    }()
    
    private lazy var caloriesLabel: UILabel = {
        makeShortInfoLabel()
    }()
    
    private lazy var proteinLabel: UILabel = {
        makeShortInfoLabel()
    }()
    
    private lazy var fatLabel: UILabel = {
        makeShortInfoLabel()
    }()
    
    private lazy var carbsLabel: UILabel = {
        makeShortInfoLabel()
    }()
    
    private lazy var nutrientsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Detailed Nutrients", for: .normal)
        button.backgroundColor = UIColor(named: "cell")
        button.tintColor = UIColor(named: "buttonTint")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showNutriesController), for: .touchUpInside)
        return button
    }()
    
    private lazy var extendedIngredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Ingredients"
        return label
    }()
    
    private lazy var measuresSegmentedControl: UISegmentedControl = {
        let items = ["Metric", "US"]
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(measuresSegmentedControlDidChange), for: .valueChanged)
        
        switch viewModel.chosenMeasure {
        case .metric:
            segmentedControl.selectedSegmentIndex = 0
        case .US:
            segmentedControl.selectedSegmentIndex = 1
        }
        
        return segmentedControl
    }()
    
    private lazy var extendedIngredientsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "cell")
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ExtendedIngredientsCollectionViewCell.self, forCellWithReuseIdentifier: ExtendedIngredientsCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Instructions"
        return label
    }()
    
    private lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var recipeSourceButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(showRecipeSource), for: .touchUpInside)
        return button
    }()
    
    private lazy var similarRecipes: SimilarRecipesView = {
        let view = SimilarRecipesView(frame: .zero, viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showRecipe = { [weak self] id in
            guard let self = self else { return }
            let recipeViewModel = RecipeViewModel(
                imageLoader: self.viewModel.getImageLoader(),
                coreDataStack: self.viewModel.getCoreDataStack(),
                recipeId: id
            )
            let recipeViewController = RecipeViewController(viewModel: recipeViewModel)
            self.navigationController?.pushViewController(recipeViewController, animated: true)
        }
        return view
    }()
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadRecipe()
        bindViewModel()
        setupViews()
        setupAutoLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            self?.changeCollectionViewHeight()
        }
    }
    
    private func bindViewModel() {
        viewModel.recipeChanged = { [weak self] in
            self?.setupRecipeData()
        }
        
        viewModel.showingSpinner = { [weak self] isLoading in
            self?.showLoadingScreen(isLoading)
        }
        
        viewModel.errorOccured = { [weak self] in
            self?.showErrorAlert()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        
        view.addSubview(scrollView)
        scrollView.addSubview(recipeStackView)
        scrollView.addSubview(similarRecipes)
    }
    
    private func makeShortInfoLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            recipeImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            
            recipeStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            recipeStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            recipeStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            similarRecipes.topAnchor.constraint(equalTo: recipeStackView.bottomAnchor, constant: 10),
            similarRecipes.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            similarRecipes.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            similarRecipes.heightAnchor.constraint(equalToConstant: 250),
            similarRecipes.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupRecipeData() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewModel.isRecipeSaved() ? deleteRecipeButton : saveRecipeButton)
        
        if let recipe = viewModel.recipe {
            
            if let image = recipe.image {
                viewModel.loadImage(image: image) { [weak self] image in
                    self?.recipeImageView.image = image
                }
            }
            
            title = recipe.title
            
            recipeTitleLabel.text = recipe.title
            readyTimeLabel.text = "Ready in " + String(recipe.readyInMinutes) + " minutes"
            servingsLabel.text = "Serving: " + String(recipe.servings)
            weightPerServingsLabel.text = "Weight per Serving: " + String(recipe.nutrition.weightPerServing.amount) + " " + recipe.nutrition.weightPerServing.unit
            bestForLabel.text = "Best for " + recipe.dishTypes.joined(separator: ", ")
            
            if let calories = recipe.nutrition.nutrients.first(where: { $0.name == "Calories" }) {
                caloriesLabel.text = "Calories: " + String(calories.amount) + " " + calories.unit
            }
            proteinLabel.text = "Protein: " + String(recipe.nutrition.caloricBreakdown.percentProtein) + "%"
            fatLabel.text = "Fat: " + String(recipe.nutrition.caloricBreakdown.percentFat) + "%"
            carbsLabel.text = "Carbs: " + String(recipe.nutrition.caloricBreakdown.percentCarbs) + "%"
            nutrientsButton.isEnabled = true
            
            extendedIngredientsCollectionView.reloadData()
            changeCollectionViewHeight()
            
            if let instructions = recipe.instructions, let sourceName = recipe.sourceName {
                if instructions.isEmpty {
                    recipeSourceButton.setTitle("Read the detailed instructions on " + sourceName, for: .normal)
                } else {
                    instructionsLabel.text = instructions.removedHtmlTags()
                }
            }
        }
    }
    
    // MARK: - Changing Collection View height
    
    private func changeCollectionViewHeight() {
        extendedIngredientsCollectionView.constraints.forEach { $0.isActive = false }
        let height = extendedIngredientsCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        extendedIngredientsCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    // MARK: - Core Data
    
    @objc private func deleteRecipe() {
        viewModel.deleteRecipeFromCoreData()
    }
    
    @objc private func saveRecipe() {
        viewModel.saveToCoreData()
    }
    
    // MARK: - Showing detailed nutrients
    
    @objc private func showNutriesController() {
        let nutrientsController = NutrientsViewController(viewModel: viewModel)
        navigationController?.pushViewController(nutrientsController, animated: true)
    }
    
    // MARK: - Changing chosen measure
    
    @objc private func measuresSegmentedControlDidChange() {
        if measuresSegmentedControl.selectedSegmentIndex == 0 {
            viewModel.setMeasureSystem(.metric)
        } else {
            viewModel.setMeasureSystem(.US)
        }
        
        extendedIngredientsCollectionView.reloadData()
    }
    
    // MARK: - Opening instructions in Safari
    
    @objc private func showRecipeSource() {
        guard let recipe = viewModel.recipe else { return }
        guard let url = URL(string: recipe.sourceUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Loading Screen
    
    private func showLoadingScreen(_ isLoading: Bool) {
        if isLoading {
            addChild(loadingScreen)
            loadingScreen.view.frame = view.frame
            view.addSubview(loadingScreen.view)
            loadingScreen.didMove(toParent: self)
        } else {
            loadingScreen.willMove(toParent: nil)
            loadingScreen.view.removeFromSuperview()
            loadingScreen.removeFromParent()
        }
    }
    
    // MARK: - Error Alert
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let recipe = viewModel.recipe {
            return recipe.extendedIngredients.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtendedIngredientsCollectionViewCell.reuseIdentifier, for: indexPath) as? ExtendedIngredientsCollectionViewCell
        else { preconditionFailure("Failed to load collection view cell") }
        
        if let recipe = viewModel.recipe {
            if let imageName = recipe.extendedIngredients[indexPath.item].image {
                viewModel.loadIngredientImage(name: imageName) { image in
                    cell.setIngredientImage(image)
                }
            } else {
                if let noImage = UIImage(named: "noImage") {
                    cell.setIngredientImage(noImage)
                }
            }
            
            cell.setName(recipe.extendedIngredients[indexPath.item].name.capitalizingFirstLetter())
            
            switch viewModel.chosenMeasure {
            case .metric:
                cell.setAmount(String(recipe.extendedIngredients[indexPath.item].measures.metric.amount) + " " + recipe.extendedIngredients[indexPath.item].measures.metric.unitLong)
            case .US:
                cell.setAmount(String(recipe.extendedIngredients[indexPath.item].measures.us.amount) + " " + recipe.extendedIngredients[indexPath.item].measures.us.unitLong)
            }
        }
        
        return cell
    }
}
