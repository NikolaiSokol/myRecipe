//
//  IngredientsCollectionViewCell.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 12.07.2021.
//

import UIKit

final class IngredientsCollectionViewCell: UICollectionViewCell {
    
    private lazy var ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAutoLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        autoresizesSubviews = true
        addSubview(ingredientImageView)
        addSubview(amountLabel)
        addSubview(nameLabel)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            ingredientImageView.topAnchor.constraint(equalTo: topAnchor),
            ingredientImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ingredientImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            amountLabel.topAnchor.constraint(equalTo: ingredientImageView.bottomAnchor, constant: 5),
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setIngredientImage(_ image: UIImage) {
        ingredientImageView.image = image
    }
    
    func setAmount(_ text: String) {
        amountLabel.text = text + " of"
    }
    
    func setName(_ text: String) {
        nameLabel.text = text
    }
}
