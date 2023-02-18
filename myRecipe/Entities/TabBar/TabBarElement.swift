//
//  TabBarElement.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import SwiftUI

struct TabBarElement: Identifiable {
    var id = UUID()
    let type: TabBarElementType
    let view: AnyView
    let item: AnyView
}
