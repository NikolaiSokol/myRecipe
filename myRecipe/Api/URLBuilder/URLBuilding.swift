//
//  URLBuilding.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

protocol URLBuilding {
    func buildURL(methodPath: MethodPath) throws -> URL
}
