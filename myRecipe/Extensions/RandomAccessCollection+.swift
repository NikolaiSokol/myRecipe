//
//  RandomAccessCollection+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import Foundation

public extension RandomAccessCollection where Self.Element: Identifiable {
    func isLastItem(_ item: Element) -> Bool {
        guard !isEmpty,
              let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) })
        else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1
    }
}
