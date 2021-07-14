//
//  SearchViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 07.06.2021.
//

import UIKit

final class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    private let loadingScreen = LoadingScreenViewController()
    
    private let viewModel: SearchViewModel
    private let imageLoader: ImageLoadingManager
    
    var autocompletionTimer: Timer?
    
    private lazy var searchController: UISearchController = {
        let resultController = SearchResultsViewController(viewModel: viewModel)
        
        let searchController = UISearchController(searchResultsController: resultController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        
        resultController.autocompletionWasChosen = { [weak self] _ in
            self?.viewModel.recipes.removeAll()
            self?.viewModel.loadRecipesWithText()
            searchController.searchBar.text = self?.viewModel.searchedText
        }
        
        return searchController
    }()
    
    private lazy var searchParametersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "slider.vertical.3"), for: .normal)
        button.tintColor = UIColor(named: "buttonTint")
        button.addTarget(self, action: #selector(showSearchParametersController), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = view.frame.height / 5
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(viewModel: SearchViewModel, imageLoader: ImageLoadingManager) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupNavigationBar()
        setupViews()
        setupAutoLayout()
    }
    
    private func bindViewModel() {
        viewModel.recipesChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.showingSpinner = { [weak self] isLoading in
            self?.showLoadingScreen(isLoading)
        }
        
        viewModel.errorOccured = { [weak self] in
            self?.showErrorAlert()
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        navigationItem.searchController = searchController
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchParametersButton)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        
        definesPresentationContext = true
        
        view.addSubview(tableView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func showSearchParametersController() {
        let parametersController = SearchParametersViewController(viewModel: viewModel)
        navigationController?.pushViewController(parametersController, animated: true)
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
    
    // MARK: - Searching
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        autocompletionTimer?.invalidate()
        autocompletionTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            self?.viewModel.searchedText = text
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
        viewModel.recipes.removeAll()
        viewModel.loadRecipesWithText()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.autocompletions.removeAll()
    }
    
    // MARK: - Infinite Scrolling
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let height = scrollView.contentSize.height - scrollView.frame.height + 5
        
        if contentOffset >= height {
            viewModel.loadMoreRecipes()
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeViewModel = RecipeViewModel(
            imageLoader: imageLoader,
            recipeId: viewModel.recipes[indexPath.row].id
        )
        let recipeViewController = RecipeViewController(viewModel: recipeViewModel)
        
        navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.recipes.isEmpty {
            tableView.setEmptyView(text: "No recipes")
        } else {
            tableView.restore()
        }
        
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell
        else { preconditionFailure("Failed to load table view cell") }
        
        cell.setRecipeName(viewModel.recipes[indexPath.row].title)
        
        let imageUrl = viewModel.recipes[indexPath.row].image
        viewModel.loadImage(url: imageUrl) { image in
            cell.setRecipeImage(image)
        }
        return cell
    }
}
