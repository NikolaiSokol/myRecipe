//
//  MultipleChoosingViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.06.2021.
//

import UIKit

final class MultipleChoosingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let items: [String]
    var selectedItems: (([String]) -> Void)?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = true
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MultipleChoosingTableViewCell.self, forCellReuseIdentifier: MultipleChoosingTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(items: [String]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
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
    
    @objc private func doneButtonTapped() {
        var selected = [String]()
        tableView.indexPathsForSelectedRows?.forEach {
            selected.append(items[$0.row])
        }
        selectedItems?(selected)
        
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MultipleChoosingTableViewCell.reuseIdentifier, for: indexPath) as? MultipleChoosingTableViewCell
        else { preconditionFailure("Failed to load table view cell") }
        
        cell.setItemName(items[indexPath.row])
        
        return cell
    }
}
