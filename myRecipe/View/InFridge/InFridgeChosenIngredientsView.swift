//
//  InFridgeChosenIngredientsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import UIKit

final class InFridgeChosenIngredientsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    private let viewModel: InFridgeViewModel

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InFridgeIngredientsCollectionViewCell.self, forCellWithReuseIdentifier: InFridgeIngredientsCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    init(frame: CGRect, viewModel: InFridgeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModel()
        setupViews()
        setupAutoLayout()
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViewModel() {
        viewModel.ingredientsChanged = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    private func setupViews() {
        backgroundColor = UIColor(named: "cell")
        addSubview(collectionView)
    }

    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.ingredients.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InFridgeIngredientsCollectionViewCell.reuseIdentifier, for: indexPath) as? InFridgeIngredientsCollectionViewCell
        else { preconditionFailure("Failed to load collection view cell") }

        cell.setName(viewModel.ingredients[indexPath.item])

        cell.deleteButtonWasTapped = { [weak self] in
            self?.viewModel.ingredients.remove(at: indexPath.item)
        }

        return cell
    }
}
