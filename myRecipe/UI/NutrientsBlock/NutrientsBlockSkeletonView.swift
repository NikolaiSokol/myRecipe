//
//  NutrientsBlockSkeletonView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import SwiftUI

struct NutrientsBlockSkeletonView: View {
    var body: some View {
        HStack {
            ForEach(0 ..< 4) { index in
                element
                
                if index < 3 {
                    Spacer()
                }
            }
        }
    }
    
    private var element: some View {
        VStack {
            ForEach(0 ..< 3) { _ in
                SkeletonView()
                    .frame(width: 70, height: 16)
                    .cornerRadius(UIConstants.Radius.xs)
            }
        }
    }
}

struct NutrientsBlockSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        NutrientsBlockSkeletonView()
    }
}
