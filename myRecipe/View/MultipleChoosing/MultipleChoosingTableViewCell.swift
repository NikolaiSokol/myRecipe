//
//  MultipleChoosingTableViewCell.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.06.2021.
//

import UIKit

final class MultipleChoosingTableViewCell: UITableViewCell {
    
    private lazy var checkBoxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "checkmark.circle")
        return imageView
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.backgroundColor = UIColor(named: "cell")
        contentView.addSubview(checkBoxImageView)
        contentView.addSubview(itemNameLabel)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            checkBoxImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            checkBoxImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkBoxImageView.heightAnchor.constraint(equalToConstant: 25),
            checkBoxImageView.widthAnchor.constraint(equalToConstant: 25),
            
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            itemNameLabel.leadingAnchor.constraint(equalTo: checkBoxImageView.trailingAnchor, constant: 10),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            itemNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkBoxImageView.tintColor = isSelected ? UIColor(named: "accent") : .systemGray4
    }
    
    func setItemName(_ text: String) {
        itemNameLabel.text = text
    }
}
