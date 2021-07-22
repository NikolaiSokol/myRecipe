//
//  IngredientsSearchResultsViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import UIKit

final class IngredientsSearchResultsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let viewModel: InFridgeViewModel
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 120)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "cell")
        collectionView.keyboardDismissMode = .onDrag
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    var autocompletionWasChosen: (() -> Void)?

    init(viewModel: InFridgeViewModel) {
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
            self?.collectionView.reloadData()
        }
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.ingredients.insert(viewModel.autocompletions[indexPath.item].name.capitalizingFirstLetter(), at: 0)
        viewModel.searchedText = ""
        autocompletionWasChosen?()
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.autocompletions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCollectionViewCell.reuseIdentifier, for: indexPath) as? IngredientsCollectionViewCell
        else { preconditionFailure("Failed to load collection view cell") }
        
        cell.setName(viewModel.autocompletions[indexPath.item].name.capitalizingFirstLetter())
        
        viewModel.loadIngredientImage(name: viewModel.autocompletions[indexPath.item].image) { image in
            cell.setIngredientImage(image)
        }
        
        return cell
    }
}
