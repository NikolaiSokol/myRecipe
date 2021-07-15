//
//  SevedRecipesViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.07.2021.
//

import UIKit
import CoreData

final class SevedRecipesViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel: SavedRecipesViewModel
    private let imageLoader: ImageLoadingManager
    private let coreDataStack: CoreDataStack
    
    private lazy var fetchedResultsController: NSFetchedResultsController<RecipeCoreData> = {
        let request = NSFetchRequest<RecipeCoreData>(entityName: "RecipeCoreData")
        request.sortDescriptors = [.init(key: "savedDate", ascending: false)]
        
        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: viewModel.getContext(),
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        frc.delegate = self
        return frc
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
    
    init(viewModel: SavedRecipesViewModel, imageLoader: ImageLoadingManager, coreDataStack: CoreDataStack) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
        self.coreDataStack = coreDataStack
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
        
        try? fetchedResultsController.performFetch()
    }
    
    private func bindViewModel() {
        viewModel.errorOccured = { [weak self] in
            self?.showErrorAlert()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
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
    
    // MARK: - Error Alert
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - FetchedResultsController delegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = fetchedResultsController.object(at: indexPath)
        
        let recipeViewModel = RecipeViewModel(
            imageLoader: imageLoader,
            coreDataStack: coreDataStack,
            coreDataRecipe: recipe
        )
        let recipeViewController = RecipeViewController(viewModel: recipeViewModel)

        navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
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
        
        let recipe = fetchedResultsController.object(at: indexPath)
        
            cell.setRecipeName(recipe.title)
            viewModel.loadImage(url: recipe.image) { image in
                cell.setRecipeImage(image)
            }
        
        return cell
    }
}
