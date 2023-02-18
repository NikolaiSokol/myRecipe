//
//  TabBarElementBuilding.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

protocol TabBarElementBuilding {
    func buildTabBarElement(view: AnyView, type: TabBarElementType) -> TabBarElement
}
