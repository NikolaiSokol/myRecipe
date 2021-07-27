//
//  NutrientsTableViewCell.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 14.07.2021.
//

import UIKit

final class NutrientsTableViewCell: UITableViewCell {
    
    private lazy var nameAndAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dailyNeedsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "accent")
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var percentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "accent")
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var ofDailyNeedsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "of daily needs"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private var dailyNeedsViewWidthConstraint = NSLayoutConstraint()

    private var dailyNeedsViewWidth: CGFloat = 0 {
        didSet {
            dailyNeedsViewWidthConstraint.isActive = false
            dailyNeedsViewWidthConstraint = dailyNeedsView.widthAnchor.constraint(equalToConstant: dailyNeedsViewWidth)
            dailyNeedsViewWidthConstraint.isActive = true
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(named: "secondBackground")
        
        contentView.addSubview(nameAndAmountLabel)
        contentView.addSubview(dailyNeedsView)
        contentView.addSubview(percentsLabel)
        contentView.addSubview(ofDailyNeedsLabel)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            nameAndAmountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameAndAmountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameAndAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dailyNeedsView.topAnchor.constraint(equalTo: nameAndAmountLabel.bottomAnchor, constant: 10),
            dailyNeedsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dailyNeedsView.heightAnchor.constraint(equalToConstant: 15),

            percentsLabel.centerYAnchor.constraint(equalTo: dailyNeedsView.centerYAnchor),
            percentsLabel.leadingAnchor.constraint(equalTo: dailyNeedsView.trailingAnchor, constant: 5),
            
            ofDailyNeedsLabel.topAnchor.constraint(equalTo: percentsLabel.bottomAnchor, constant: 5),
            ofDailyNeedsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ofDailyNeedsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ofDailyNeedsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    func setupNutrients(nutrients: Nutrients) {
        nameAndAmountLabel.text = nutrients.name + ": " + String(nutrients.amount) + " " + nutrients.unit
        percentsLabel.text = String(nutrients.percentOfDailyNeeds) + " %"

        setupDailyNeedsViewWidth(percentOfDailyNeeds: nutrients.percentOfDailyNeeds)
    }

    private func setupDailyNeedsViewWidth(percentOfDailyNeeds: Float) {
        let availableWidth = safeAreaLayoutGuide.layoutFrame.width - percentsLabel.intrinsicContentSize.width - 25

        if percentOfDailyNeeds >= 100 {
            dailyNeedsViewWidth = availableWidth
        } else {
            dailyNeedsViewWidth = availableWidth / 100 * CGFloat(percentOfDailyNeeds)
        }
    }
}
