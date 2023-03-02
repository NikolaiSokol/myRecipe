//
//  NutrientsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import SwiftUI

struct NutrientsView: View {
    private let nutrients: [Nutrient]
    
    init(nutrients: [Nutrient]) {
        self.nutrients = nutrients
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            content
        }
    }
    
    private var content: some View {
        VStack {
            ForEach(nutrients, id: \.id) {
                NutrientRowView(nutrient: $0)
            }
        }
        .padding(.top, UIConstants.Paddings.xl)
    }
}

struct NutrientsView_Previews: PreviewProvider {
    static var previews: some View {
        NutrientsView(
            nutrients: [
                Nutrient(
                    name: "Calories",
                    amount: "543.36",
                    unit: "kcal",
                    percentOfDailyNeeds: 29.26
                ),
                Nutrient(
                    name: "Fat",
                    amount: "16.2",
                    unit: "g",
                    percentOfDailyNeeds: 30.7
                ),
                Nutrient(
                    name: "Protein",
                    amount: "16.84",
                    unit: "g",
                    percentOfDailyNeeds: 37.49
                )
            ]
        )
    }
}
