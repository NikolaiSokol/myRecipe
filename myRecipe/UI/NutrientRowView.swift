//
//  NutrientRowView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import SwiftUI

struct NutrientRowView: View {
    private enum LocalConstants {
        static let percentageHeight: CGFloat = 16
        static let contentNameSpace = "NutrientRowViewContentNameSpace"
        static let percentageTextNameSpace = "NutrientsViewPercentageTextNameSpace"
    }
    
    private var nutrient: Nutrient
    
    @State private var contentSize: CGSize = .zero
    @State private var percentageTextSize: CGSize = .zero
    
    init(nutrient: Nutrient) {
        self.nutrient = nutrient
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.Paddings.xxxs) {
            HStack {
                Text(nutrient.name + ":")
                    .customFont(size: UIConstants.Font.l)
                
                Text(nutrient.amount)
                    .customFont(size: UIConstants.Font.l)
                    .fontWeight(.semibold)
                
                Text(nutrient.unit)
                    .customFont(size: UIConstants.Font.m)
            }
            
            percentOfDailyNeeds(nutrient.percentOfDailyNeeds)
            
            Text(String(localized: .ofDailyNeeds))
                .customFont(size: UIConstants.Font.xs)
            
            Separator()
        }
        .getViewSize(
            $contentSize,
            spaceName: LocalConstants.contentNameSpace
        )
    }
    
    private func percentOfDailyNeeds(_ percent: Double) -> some View {
        HStack(spacing: UIConstants.Paddings.xxs) {
            RoundedRectangle(cornerRadius: LocalConstants.percentageHeight / 2)
                .foregroundColor(Color(.primaryAccent))
                .frame(height: LocalConstants.percentageHeight)
                .frame(maxWidth: calculatePercentOfDailyNeedsWidth(percent))
            
            Text(String(percent) + " %")
                .customFont(size: UIConstants.Font.l)
                .foregroundColor(Color(.primaryAccent))
                .getViewSize(
                    $percentageTextSize,
                    spaceName: LocalConstants.percentageTextNameSpace
                )
        }
    }
    
    private func calculatePercentOfDailyNeedsWidth(_ percent: Double) -> CGFloat {
        guard percent <= 100, !contentSize.width.isZero else {
            return .infinity
        }
        
        let availableWidth = contentSize.width
        - UIConstants.Paddings.xxs
        - percentageTextSize.width
        
        return availableWidth * percent / 100
    }
}

struct NutrientRowView_Previews: PreviewProvider {
    static var previews: some View {
        NutrientRowView(
            nutrient: Nutrient(
                name: "Calories",
                amount: "543.36",
                unit: "kcal",
                percentOfDailyNeeds: 29.26
            )
        )
    }
}
