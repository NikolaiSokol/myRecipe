//
//  SimilarRecipesView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import UIKit

final class SimilarRecipesView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let viewModel: RecipeViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Similar Recipes"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SimilarRecipesCollectionViewCell.self, forCellWithReuseIdentifier: SimilarRecipesCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    var showRecipe: ((Int) -> Void)?
    
    init(frame: CGRect, viewModel: RecipeViewModel) {
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
        viewModel.similarRecipesChanged = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupViews() {
        backgroundColor = UIColor(named: "cell")
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showRecipe?(viewModel.similarRecipes[indexPath.item].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.similarRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarRecipesCollectionViewCell.reuseIdentifier, for: indexPath) as? SimilarRecipesCollectionViewCell
        else { preconditionFailure("Failed to load collection view cell") }
        
        cell.setRecipeName(viewModel.similarRecipes[indexPath.item].title)
        
        viewModel.loadImage(image: viewModel.similarRecipes[indexPath.item].image) { image in
            cell.setRecipeImage(image)
        }
        
        return cell
    }
}
