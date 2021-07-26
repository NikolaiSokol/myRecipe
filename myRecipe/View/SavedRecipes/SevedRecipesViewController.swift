//
//  SevedRecipesViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//

import UIKit

final class SevedRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    private let viewModel: SavedRecipesViewModel
    private let imageLoader: ImageLoadingManager
    private let coreDataStack: CoreDataStack
    private let session: URLSessionProtocol
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "background")
        tableView.rowHeight = view.frame.height / 5
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(viewModel: SavedRecipesViewModel, imageLoader: ImageLoadingManager, coreDataStack: CoreDataStack, session: URLSessionProtocol) {
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
        
        viewModel.performFetch()
    }
    
    private func bindViewModel() {
        viewModel.recipesChanged = { [weak self] in
            guard let self = self else { return }
            UIView.transition(
                with: self.tableView,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: { self.tableView.reloadData() },
                completion: nil
            )
        }
        
        viewModel.errorOccured = { [weak self] in
            self?.showErrorAlert()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        navigationItem.searchController = searchController
        
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
    
    // MARK: - Searching
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.searchedText = text
    }
    
    // MARK: - Error Alert
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        let recipe = viewModel.fetchedResultsController.object(at: indexPath)
        viewModel.deleteRecipeFromCoreData(id: Int(recipe.id))
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.fetchedResultsController.object(at: indexPath)
        
        let recipeViewModel = RecipeViewModel(
            networkManager: RecipeNetworkManager(session: session),
            imageLoader: imageLoader,
            coreDataStack: coreDataStack,
            coreDataRecipe: recipe
        )
        let recipeViewController = RecipeViewController(viewModel: recipeViewModel)

        navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewModel.fetchedResultsController.sections else { return 0 }
        let numberOfRows = sections[section].numberOfObjects
        if numberOfRows == 0 {
            tableView.setEmptyView(text: "No saved recipes")
        } else {
            tableView.restore()
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell
        else { preconditionFailure("Failed to load table view cell") }
        
        let recipe = viewModel.fetchedResultsController.object(at: indexPath)
        
            cell.setRecipeName(recipe.title)
        
        if let image = recipe.image {
            viewModel.loadImage(url: image) { image in
                cell.setRecipeImage(image)
            }
        } else {
            if let noImage = UIImage(named: "noImage") {
                cell.setRecipeImage(noImage)
            }
        }
        
        return cell
    }
}
