//
//  InstructionRowView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 25.02.2023.
//

import SwiftUI

struct InstructionRowView: View {
    private enum LocalConstants {
        static let numberCircleSize: CGFloat = 30
        static let imageHeight: CGFloat = 60
        static let imageMaxWidth: CGFloat = 80
        static let maxIngredientsToShow = 3
    }
    
    private let step: RecipeInstructionStep
    
    init(step: RecipeInstructionStep) {
        self.step = step
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            number
            
            stepContent
        }
    }
    
    private var number: some View {
        Circle()
            .foregroundColor(Color(.primaryLightAccent))
            .frame(height: LocalConstants.numberCircleSize)
            .overlay {
                Text(String(step.number))
                    .customFont(size: UIConstants.Font.m)
                    .foregroundColor(Color(.primaryAccent))
                    .fontWeight(.semibold)
            }
    }
    
    private var stepContent: some View {
        VStack(alignment: .leading, spacing: UIConstants.Paddings.xxs) {
            Text(step.text)
                .customFont(size: UIConstants.Font.m)
                .textSelection(.enabled)
            
            ingredients
        }
        .padding(.top, UIConstants.Paddings.xxxs)
        .padding(.leading, UIConstants.Paddings.s)
    }
    
    private var ingredients: some View {
        HStack(spacing: UIConstants.Paddings.s) {
            ForEach(
                step.ingredients.prefix(LocalConstants.maxIngredientsToShow),
                id: \.id
            ) {
                image(url: $0.imageUrl)
            }
            
            Spacer()
        }
    }
    
    private func image(url: URL?) -> some View {
        // swiftlint:disable:next multiline_arguments
        AsyncImage(url: url) {
            $0.resizable()
        } placeholder: {
            imagePlaceholder
        }
        .scaledToFit()
        .frame(height: LocalConstants.imageHeight)
        .frame(maxWidth: LocalConstants.imageMaxWidth)
    }
    
    private var imagePlaceholder: some View {
        Image(.placeholder)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color(.accentGray))
            .scaledToFit()
            .frame(height: LocalConstants.imageHeight)
            .frame(maxWidth: LocalConstants.imageMaxWidth)
    }
}

struct InstructionRowView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionRowView(
            step: RecipeInstructionStep(
                number: 1,
                text: "Combine all liquid ingredients in a blender.",
                ingredients: [
                    RecipeIngredient(
                        id: 0,
                        name: "",
                        imageUrl: URL(string: ApiConstants.ingredientImageUrl + "flour.png"),
                        measures: nil
                    ),
                    RecipeIngredient(
                        id: 1,
                        name: "",
                        imageUrl: URL(string: ApiConstants.ingredientImageUrl + "butter-sliced.jpg"),
                        measures: nil
                    ),
                    RecipeIngredient(
                        id: 2,
                        name: "",
                        imageUrl: URL(string: ApiConstants.ingredientImageUrl + "crepes-isolated.jpg"),
                        measures: nil
                    )
                ]
            )
        )
    }
}
