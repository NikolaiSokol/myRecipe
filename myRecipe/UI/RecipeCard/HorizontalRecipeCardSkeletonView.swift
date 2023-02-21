//
//  HorizontalRecipeCardSkeletonView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import SwiftUI

struct HorizontalRecipeCardSkeletonView: View {
    var body: some View {
        Rectangle()
            .overlay {
                SkeletonView()
            }
            .foregroundColor(Color("primaryLightAccent"))
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .cornerRadius(UIConstants.Radius.l)
    }
}

struct HorizontalRecipeCardSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRecipeCardSkeletonView()
    }
}
