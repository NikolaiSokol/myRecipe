//
//  SearchResultsViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 17.06.2021.
//

import UIKit

final class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel: SearchViewModel
    
    var autocompletionWasChosen: ((Bool) -> Void)?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.reuseIdentifier)
        return tableView
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
        bindViewModel()
        setupViews()
        setupAutoLayout()
    }
    
    private func bindViewModel() {
        viewModel.autocompletionsChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupViews() {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.searchedText = viewModel.autocompletions[indexPath.row].title.capitalizingFirstLetter()
        autocompletionWasChosen?(true)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.autocompletions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultsTableViewCell
        else { preconditionFailure("Failed to load table view cell") }
        
        cell.setautocompletionLabelText(viewModel.autocompletions[indexPath.row].title.capitalizingFirstLetter())
        
        return cell
    }
}
