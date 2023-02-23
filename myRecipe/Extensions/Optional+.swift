//
//  Optional+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import Foundation
import Combine

extension Optional {
    var isNil: Bool {
        self == nil
    }
}

extension Optional where Wrapped: Combine.Publisher {
    func orEmpty() -> AnyPublisher<Wrapped.Output, Wrapped.Failure> {
        self?.eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
    }
}
