//
//  MainScreenCoordinatorOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

protocol MainScreenCoordinatorOutput: AnyObject {
    func mainScreenCoordinatorDidRequest(event: MainScreenCoordinatorEvent)
}
