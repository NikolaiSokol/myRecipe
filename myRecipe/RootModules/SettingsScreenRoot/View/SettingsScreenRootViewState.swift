//
//  SettingsScreenRootViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import Combine

final class SettingsScreenRootViewState: ObservableObject {
    @Published var chosenMeasureSystem: MeasureSystem = .us
    @Published var chosenIntolerances: Set<IntoleranceType> = []

    var intolerances: [IntoleranceType] = []
}
