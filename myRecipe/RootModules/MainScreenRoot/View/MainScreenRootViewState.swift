//
//  MainScreenRootViewState.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation
import Combine

final class MainScreenRootViewState: ObservableObject {
    @Published var searchBoxModel: SearchBoxModel?
    @Published var randomRecipesByTypeModel: RandomRecipesByTypeModel?
    
    let showTopSectionSubject = PassthroughSubject<Void, Never>()
}
