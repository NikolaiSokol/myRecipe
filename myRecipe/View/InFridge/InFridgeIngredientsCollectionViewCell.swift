//
//  InFridgeChosenIngredientsCollectionViewCell.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.07.2021.
//

import UIKit

final class InFridgeIngredientsCollectionViewCell: UICollectionViewCell {

    private lazy var nameBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "accent")
        view.layer.cornerRadius = 25
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteIngredient), for: .touchUpInside)
        button.accessibilityIdentifier = "deleteIngredientButton"
        return button
    }()

    var deleteButtonWasTapped: (() -> Void)?

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
        addSubview(nameBackgroundView)
        nameBackgroundView.addSubview(nameLabel)
        nameBackgroundView.addSubview(deleteButton)
    }

    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            nameBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            nameBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            nameLabel.centerYAnchor.constraint(equalTo: nameBackgroundView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameBackgroundView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: nameBackgroundView.trailingAnchor, constant: -35),

            deleteButton.centerYAnchor.constraint(equalTo: nameBackgroundView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: nameBackgroundView.trailingAnchor, constant: -5),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc private func deleteIngredient() {
        deleteButtonWasTapped?()
    }

    func setName(_ text: String) {
        nameLabel.text = text
    }
}
