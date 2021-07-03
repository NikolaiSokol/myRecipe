//
//  UITableView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 29.06.2021.
//

import UIKit

extension UITableView {
    
    func setEmptyView(text: String) {
        let emptyView = UIView(
            frame: CGRect(
                x: center.x,
                y: center.y,
                width: bounds.size.width,
                height: bounds.size.height)
        )
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = UIColor(named: "noResults")
        label.text = text
        
        emptyView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
        ])
        
        backgroundView = emptyView
        separatorStyle = .none
    }
    
    func restore() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
