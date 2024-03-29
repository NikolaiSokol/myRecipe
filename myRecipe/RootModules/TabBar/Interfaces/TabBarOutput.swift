//
//  TabBarOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

protocol TabBarOutput: AnyObject {
    func didTapSelectedTab(_ tab: TabBarElementType)
}
