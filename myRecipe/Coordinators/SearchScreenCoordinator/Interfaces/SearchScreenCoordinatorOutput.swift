//
//  SearchScreenCoordinatorOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//

import Foundation

protocol SearchScreenCoordinatorOutput: AnyObject {
    func searchScreenCoordinatorDidRequest(event: SearchScreenCoordinatorEvent)
}
