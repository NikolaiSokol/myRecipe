//
//  NavigableView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

struct NavigableView: Navigable {
    let id = UUID()
    let view: AnyView
}
