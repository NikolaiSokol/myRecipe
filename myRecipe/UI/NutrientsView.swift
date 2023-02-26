//
//  NutrientsView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import SwiftUI

struct NutrientsView: View {
    @Environment(\.dismiss) var dismiss
    
    private let nutrients: [Nutrient]
    
    init(nutrients: [Nutrient]) {
        self.nutrients = nutrients
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                closeButton
                
                content
            }
            .padding(.horizontal, UIConstants.Paddings.s)
        }
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            
            Button(action: close) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding(UIConstants.Paddings.xs)
                    .background(
                        Circle()
                            .foregroundColor(Color(.accentGray))
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.top, UIConstants.Paddings.s)
    }
    
    private var content: some View {
        VStack {
            ForEach(nutrients, id: \.id) {
                NutrientRowView(nutrient: $0)
            }
        }
        .padding(.top, UIConstants.Paddings.m)
    }
    
    private func close() {
        dismiss()
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
