//
//  IngredientRowView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 25.02.2023.
//

import SwiftUI

struct IngredientRowView: View {
    private enum LocalConstants {
        static let size: CGFloat = 60
    }
    
    private let ingredient: RecipeIngredient
    private let measureType: MeasureType
    
    init(
        ingredient: RecipeIngredient,
        measureType: MeasureType
    ) {
        self.ingredient = ingredient
        self.measureType = measureType
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            image
            
            name
            
            Spacer()
            
            amount
        }
        .frame(height: LocalConstants.size)
    }
    
    private var image: some View {
        // swiftlint:disable:next multiline_arguments
        AsyncImage(url: ingredient.imageUrl) {
            $0.resizable()
        } placeholder: {
            imagePlaceholder
        }
        .scaledToFit()
        .frame(width: LocalConstants.size)
    }
    
    private var imagePlaceholder: some View {
        Image(.placeholder)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color(.accentGray))
            .scaledToFit()
            .padding(UIConstants.Paddings.xs)
            .frame(width: LocalConstants.size)
    }
    
    private var name: some View {
        Text(ingredient.name.capitalizingFirstLetter())
            .customFont(size: UIConstants.Font.m)
            .textSelection(.enabled)
            .lineLimit(2)
            .padding(.leading, UIConstants.Paddings.s)
    }
    
    @ViewBuilder private var amount: some View {
        if let measures = ingredient.measures {
            let amountAndMeasure = getAmountAndMeasure(measures)
            
            HStack(spacing: UIConstants.Paddings.xxs) {
                Text(amountAndMeasure.amount)
                    .customFont(size: UIConstants.Font.m)
                
                Text(amountAndMeasure.measure)
                    .customFont(size: UIConstants.Font.m)
            }
        }
    }
    
    private func getAmountAndMeasure(
        _ measures: Measures
    ) -> (amount: String, measure: String) {
        switch measureType {
        case .us:
            return (
                String(measures.us.amount.round(to: 2)),
                measures.us.unitShort
            )
            
        case .metric:
            return (
                String(measures.metric.amount.round(to: 2)),
                measures.metric.unitShort
            )
        }
    }
}

struct IngredientRowView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRowView(
            ingredient: RecipeIngredient(
                id: 0,
                name: "flour",
                imageUrl: URL(string: ApiConstants.ingredientImageUrl + "flour.png"),
                measures: Measures(
                    us: Measure(amount: 1.5, unitShort: "cups"),
                    metric: Measure(amount: 354.882, unitShort: "ml")
                )
            ),
            measureType: .us
        )
    }
}
