//
//  SearchResultsTableViewCell.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 17.06.2021.
//

import UIKit

final class SearchResultsTableViewCell: UITableViewCell {
    
    private lazy var autocompletionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(autocompletionLabel)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            autocompletionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            autocompletionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            autocompletionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            autocompletionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func setautocompletionLabelText(_ text: String) {
        autocompletionLabel.text = text
    }
}
