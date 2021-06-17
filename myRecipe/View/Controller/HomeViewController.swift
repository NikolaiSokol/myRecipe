//
//  HomeViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 07.06.2021.
//

import UIKit
import Combine

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    private let viewModel: HomeViewModel
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var searchController: UISearchController = {
        let resultController = SearchResultsViewController(viewModel: viewModel)
        
        let searchController = UISearchController(searchResultsController: resultController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        
        resultController.selectedAutocompletion = { [weak self] text in
            self?.viewModel.recipes.removeAll()
            self?.viewModel.loadRecipesWith(text: text)
            searchController.searchBar.text = text
        }
        
        return searchController
    }()
    
    private lazy var parametersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = UIColor(named: "buttonTint")
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "background")
        tableView.rowHeight = 180
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
    }
    
    private func bindViewModel() {
        viewModel.$recipes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        navigationItem.searchController = searchController
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: parametersButton)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        
        definesPresentationContext = true

        view.addSubview(tableView)
        setupAutoLayout()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
        viewModel.recipes.removeAll()
        viewModel.loadRecipesWith(text: viewModel.searchedText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.autocompletions.removeAll()
    }
    
    // MARK: - Infinite Scrolling
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !viewModel.recipes.isEmpty {
            viewModel.loadRecipesWith(text: viewModel.searchedText)
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as? HomeTableViewCell
        else { preconditionFailure("Failed to load table view cell") }
        
        cell.setRecipeName(viewModel.recipes[indexPath.row].title)
        
        let imageUrl = viewModel.recipes[indexPath.row].image
        viewModel.loadImage(url: imageUrl) { image in
            cell.setRecipeImage(image)
        }
        
        return cell
    }
}
