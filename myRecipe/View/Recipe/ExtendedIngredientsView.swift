//
//  ExtendedIngredientsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import UIKit

final class ExtendedIngredientsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    private let viewModel: RecipeViewModel

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 200)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "secondBackground")
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    init(frame: CGRect, viewModel: RecipeViewModel) {
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let recipe = viewModel.recipe {
            return recipe.extendedIngredients.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCollectionViewCell.reuseIdentifier, for: indexPath) as? IngredientsCollectionViewCell
        else { preconditionFailure("Failed to load collection view cell") }

        if let recipe = viewModel.recipe {
            if let imageName = recipe.extendedIngredients[indexPath.item].image {
                viewModel.loadIngredientImage(name: imageName) { image in
                    cell.setIngredientImage(image)
                }
            } else {
                if let noImage = UIImage(named: "noImage") {
                    cell.setIngredientImage(noImage)
                }
            }

            cell.setName(recipe.extendedIngredients[indexPath.item].name.capitalizingFirstLetter())
            
            switch viewModel.chosenMeasure {
            case .metric:
                cell.setAmount(String(recipe.extendedIngredients[indexPath.item].measures.metric.amount) + " " + recipe.extendedIngredients[indexPath.item].measures.metric.unitLong)
            case .US:
                cell.setAmount(String(recipe.extendedIngredients[indexPath.item].measures.us.amount) + " " + recipe.extendedIngredients[indexPath.item].measures.us.unitLong)
            }
        }

        return cell
    }
}
