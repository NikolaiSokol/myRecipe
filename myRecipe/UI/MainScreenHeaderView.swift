//
//  MainScreenHeaderView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import SwiftUI

struct MainScreenHeaderView: View {
    private enum LocalConstants {
        static let circleHeight: CGFloat = 36
        static let imageSize: CGFloat = 20
    }
    
    var body: some View {
        HStack {
            text
            
            Spacer()
            
            circle
        }
    }
    
    private var text: some View {
        VStack(alignment: .leading, spacing: UIConstants.Paddings.xxxs) {
            Text(String(localized: .hello))
                .customFont(size: UIConstants.Font.l)
                .bold()
                .foregroundColor(Color(.primaryAccent))
            
            Text(String(localized: .whatYouWantToCook))
                .customFont(size: UIConstants.Font.m)
                .foregroundColor(Color(.accentGray))
        }
    }
    
    private var circle: some View {
        Circle()
            .foregroundColor(Color(.primaryAccent))
            .frame(height: LocalConstants.circleHeight)
            .overlay {
                image
            }
    }
    
    private var image: some View {
        Image(.placeholder)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color(.primaryLightAccent))
            .frame(width: LocalConstants.imageSize, height: LocalConstants.imageSize)
    }
}

struct MainScreenHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenHeaderView()
    }
}
