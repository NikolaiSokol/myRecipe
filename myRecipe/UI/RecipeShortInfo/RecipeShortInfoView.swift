//
//  RecipeShortInfoView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import SwiftUI

struct RecipeShortInfoView: View {
    private let type: RecipeShortInfoType
    private let text: String
    
    init(
        type: RecipeShortInfoType,
        text: String
    ) {
        self.type = type
        self.text = text
    }
    
    var body: some View {
        VStack(spacing: UIConstants.Paddings.xxs) {
            topSection
            
            name
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, UIConstants.Paddings.xxs)
        .padding(.horizontal, UIConstants.Paddings.xxxs)
        .background(background)
    }
    
    private var topSection: some View {
        HStack(spacing: UIConstants.Paddings.xxs) {
            image
                .foregroundColor(Color(.primaryAccent))
                .scaledToFit()
                .frame(width: UIConstants.Font.s)
                
            Text(text)
                .customFont(size: UIConstants.Font.xs)
                .lineLimit(1)
                .foregroundColor(Color(.primaryAccent))
                .fontWeight(.semibold)
        }
    }
    
    private var name: some View {
        Text(getName())
            .customFont(size: UIConstants.Font.xs)
            .foregroundColor(Color(.textAccent))
    }
    
    private var image: some View {
        var imageName: String
        
        switch type {
        case .cookTime:
            imageName = "clock"
            
        case .serves:
            imageName = "person"
            
        case .cuisine:
            imageName = "mappin.and.ellipse"
            
        case .perfectFor:
            imageName = "star"
        }
        
        return Image(systemName: imageName)
            .resizable()
    }
    
    private func getName() -> String {
        switch type {
        case .cookTime:
            return String(localized: .cookTime)
            
        case .serves:
            return String(localized: .serves)
            
        case .cuisine:
            return String(localized: .cuisine)
            
        case .perfectFor:
            return String(localized: .perfectFor)
        }
    }
    
    private var background: some View {
        Rectangle()
            .foregroundColor(Color(.secondaryGray))
            .cornerRadius(UIConstants.Radius.s)
    }
}

struct RecipeShortInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeShortInfoView(type: .cookTime, text: "10 min")
    }
}
