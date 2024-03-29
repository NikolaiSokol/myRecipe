//
//  Double+.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 25.02.2023.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
