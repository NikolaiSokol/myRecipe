//
//  InFridgeSearchViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.07.2021.
//

import UIKit

final class InFridgeSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let loadingScreen = LoadingScreenViewController()

    private let viewModel: InFridgeViewModel
    private let imageLoader: ImageLoadingManager
    private let coreDataStack: CoreDataStack
    private let session: URLSessionProtocol

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

    private lazy var newSearchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New Search", for: .normal)
        button.backgroundColor = UIColor(named: "cell")
        button.tintColor = UIColor(named: "accent")
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(named: "accent")?.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(newSearch), for: .touchUpInside)
        return button
    }()

    var newSearchButtonWasTapped: (() -> Void)?

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

    private func bindViewModel() {
        viewModel.recipesChanged = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.showingSpinner = { [weak self] isLoading in
            self?.showLoadingScreen(isLoading)
        }
    }

    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(newSearchButton)
    }

    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            newSearchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            newSearchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            newSearchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            newSearchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func newSearch() {
        newSearchButtonWasTapped?()
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

    // MARK: - Table View

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeViewModel = RecipeViewModel(
            networkManager: RecipeNetworkManager(session: session),
            imageLoader: imageLoader,
            coreDataStack: coreDataStack,
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
