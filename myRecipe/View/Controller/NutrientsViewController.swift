//
//  NutrientsViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.07.2021.
//

import UIKit

final class NutrientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel: RecipeViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NutrientsTableViewCell.self, forCellReuseIdentifier: NutrientsTableViewCell.reuseIdentifier)
        return tableView
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
        setupViews()
        setupAutoLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        title = "Nutrients"
        
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let nutrients = viewModel.recipe?.nutrition.nutrients {
            return nutrients.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NutrientsTableViewCell.reuseIdentifier, for: indexPath) as? NutrientsTableViewCell
        else { preconditionFailure("Failed to load table view cell") }
        
        if let nutrients = viewModel.recipe?.nutrition.nutrients {
            cell.setupCell(nutrients: nutrients[indexPath.row])
        }
        
        return cell
    }
}
