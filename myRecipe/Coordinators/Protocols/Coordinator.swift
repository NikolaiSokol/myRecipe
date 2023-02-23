//
//  Coordinator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

protocol CoordinatorOption {}

protocol Coordinator: AnyObject {
    func start(with option: CoordinatorOption?)
}
