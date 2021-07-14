//
//  SearchTableViewCell.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.06.2021.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private lazy var recipeNameLabelBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if let color = UIColor(named: "background") {
            view.backgroundColor = color.withAlphaComponent(0.7)
        }
        return view
    }()
    
    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(named: "cell")
        
        contentView.addSubview(recipeImageView)
        recipeImageView.addSubview(recipeNameLabelBackground)
        recipeNameLabelBackground.addSubview(recipeNameLabel)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            recipeNameLabelBackground.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor),
            recipeNameLabelBackground.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
            recipeNameLabelBackground.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            recipeNameLabelBackground.heightAnchor.constraint(equalTo: recipeNameLabel.heightAnchor),
            
            recipeNameLabel.topAnchor.constraint(equalTo: recipeNameLabelBackground.topAnchor),
            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeNameLabelBackground.leadingAnchor, constant: 10),
            recipeNameLabel.trailingAnchor.constraint(equalTo: recipeNameLabelBackground.trailingAnchor, constant: -10)
        ])
    }
    
    func setRecipeName(_ name: String) {
        recipeNameLabel.text = name
    }
    
    func setRecipeImage(_ image: UIImage) {
        recipeImageView.image = image
    }
}
