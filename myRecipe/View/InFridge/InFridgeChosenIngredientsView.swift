//
//  InFridgeChosenIngredientsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import UIKit

final class InFridgeChosenIngredientsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let viewModel: InFridgeViewModel

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InFridgeIngredientsCollectionViewCell.self, forCellWithReuseIdentifier: InFridgeIngredientsCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    init(frame: CGRect, viewModel: InFridgeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupViews()
        setupAutoLayout()
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = UIColor(named: "secondBackground")
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

    func reloadData() {
        collectionView.reloadData()
    }

    func getContentSizeHeight() -> CGFloat {
        collectionView.collectionViewLayout.collectionViewContentSize.height
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel.ingredients[indexPath.item]
        let itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ])

        return CGSize(width: itemSize.width + 50, height: 50)
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
