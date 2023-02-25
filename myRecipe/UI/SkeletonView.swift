//
//  SkeletonView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import SwiftUI

struct SkeletonView: View {
    private enum LocalConstants {
        static let idlePoints = LinearGradientPoints(
            start: UnitPoint(x: -1, y: -1),
            end: UnitPoint(x: 0, y: 0)
        )
        
        static let animationPoints = LinearGradientPoints(
            start: UnitPoint(x: 1, y: 1),
            end: UnitPoint(x: 4, y: 4)
        )
    }
    
    private let gradient = Gradient(
        colors: [
            Color(.accentGray),
            Color(.secondaryGray),
            Color(.accentGray)
        ]
    )
    
    private let activeAnimation = Animation.linear(duration: 1.5)
        .repeatForever(autoreverses: false)
    private let stopAnimation = Animation.linear(duration: 0)
    
    @State var currentGradientPoints = LocalConstants.idlePoints
    
    var body: some View {
        LinearGradient(
            gradient: gradient,
            startPoint: currentGradientPoints.start,
            endPoint: currentGradientPoints.end
        )
        .onAppear {
            withAnimation(activeAnimation) {
                currentGradientPoints = LocalConstants.animationPoints
            }
        }
        .onDisappear {
            withAnimation(stopAnimation) {
                currentGradientPoints = LocalConstants.idlePoints
            }
        }
    }
}

struct SkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonView()
    }
}
