//
//  InFridgeViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import UIKit

final class InFridgeViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    private let viewModel: InFridgeViewModel
    private let imageLoader: ImageLoadingManager
    private let coreDataStack: CoreDataStack
    private let session: URLSessionProtocol
    
    private var autocompletionTimer: Timer?
    private var chosenIngredientsViewHeightConstraint = NSLayoutConstraint()
    
    private lazy var searchController: UISearchController = {
        let searchResultsController = IngredientsSearchResultsViewController(viewModel: viewModel)
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.placeholder = "Search for Ingredients"
        
        searchResultsController.autocompletionWasChosen = {
            searchController.searchBar.text = nil
        }
        
        return searchController
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var whatsInFridgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "What's in your fridge?"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()

    private lazy var addIngredientButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = UIColor(named: "accent")
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        button.accessibilityIdentifier = "addIngredientButton"
        return button
    }()

    private lazy var chosenIngredientsView: InFridgeChosenIngredientsView = {
        let view = InFridgeChosenIngredientsView(frame: .zero, viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.tintColor = UIColor(named: "accent")
        button.backgroundColor = UIColor(named: "secondBackground")
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(named: "accent")?.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(showSearchResults), for: .touchUpInside)
        button.isEnabled = false
        button.accessibilityIdentifier = "searchByIngredientsButton"
        return button
    }()

    private lazy var searchResultsController: InFridgeSearchViewController = {
        let controller = InFridgeSearchViewController(viewModel: viewModel, imageLoader: imageLoader, coreDataStack: coreDataStack, session: session)

        controller.newSearchButtonWasTapped = { [weak self] in
            self?.hideSearchResults()
        }

        return controller
    }()
    
    init(viewModel: InFridgeViewModel, imageLoader: ImageLoadingManager, coreDataStack: CoreDataStack, session: URLSessionProtocol) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
        self.coreDataStack = coreDataStack
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupViews()
        setupAutoLayout()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            self?.changeChosenIngredientsViewHeight()
        }
    }

    private func bindViewModel() {
        viewModel.ingredientsChanged = { [weak self] in
            guard let self = self else { return }
            self.chosenIngredientsView.reloadData()
            self.changeChosenIngredientsViewHeight()
            self.searchButton.isEnabled = !self.viewModel.ingredients.isEmpty
        }

        viewModel.errorOccured = { [weak self] in
            self?.showErrorAlert()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        navigationItem.searchController = searchController

        view.addSubview(scrollView)
        scrollView.addSubview(whatsInFridgeLabel)
        scrollView.addSubview(chosenIngredientsView)
        scrollView.addSubview(addIngredientButton)
        scrollView.addSubview(searchButton)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            whatsInFridgeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            whatsInFridgeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            whatsInFridgeLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),

            chosenIngredientsView.topAnchor.constraint(equalTo: whatsInFridgeLabel.bottomAnchor, constant: 10),
            chosenIngredientsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            chosenIngredientsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),

            addIngredientButton.topAnchor.constraint(equalTo: chosenIngredientsView.bottomAnchor, constant: 10),
            addIngredientButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            addIngredientButton.widthAnchor.constraint(equalToConstant: 50),
            addIngredientButton.heightAnchor.constraint(equalToConstant: 50),

            searchButton.topAnchor.constraint(equalTo: addIngredientButton.bottomAnchor, constant: 10),
            searchButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            searchButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private func changeChosenIngredientsViewHeight() {
        chosenIngredientsViewHeightConstraint.isActive = false
        chosenIngredientsViewHeightConstraint = chosenIngredientsView.heightAnchor.constraint(
            equalToConstant: chosenIngredientsView.getContentSizeHeight()
        )
        chosenIngredientsViewHeightConstraint.isActive = true
    }

    @objc private func addIngredient() {
        searchController.searchBar.becomeFirstResponder()
    }

    @objc private func showSearchResults() {
        searchController.searchBar.isHidden = true

        addChild(searchResultsController)
        searchResultsController.view.frame = view.safeAreaLayoutGuide.layoutFrame
        view.addSubview(searchResultsController.view)
        searchResultsController.didMove(toParent: self)

        viewModel.loadRecipes()
    }

    private func hideSearchResults() {
        viewModel.ingredients.removeAll()
        searchController.searchBar.isHidden = false

        searchResultsController.willMove(toParent: nil)
        searchResultsController.view.removeFromSuperview()
        searchResultsController.removeFromParent()
    }
    
    // MARK: - Searching
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        autocompletionTimer?.invalidate()
        autocompletionTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            self?.viewModel.searchedText = text
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.ingredients.insert(text, at: 0)
        viewModel.autocompletions.removeAll()
        searchController.searchBar.text = nil
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.autocompletions.removeAll()
    }

    // MARK: - Error Alert

    private func showErrorAlert() {
        let alert = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)

        present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
