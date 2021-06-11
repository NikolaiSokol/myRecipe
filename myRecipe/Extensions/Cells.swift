//
//  Cells.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import UIKit

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifying {}

extension UICollectionViewCell: ReuseIdentifying {}
