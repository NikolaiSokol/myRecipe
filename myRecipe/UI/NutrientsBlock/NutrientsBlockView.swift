//
//  NutrientsBlockView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import SwiftUI

struct NutrientsBlockView: View {
    private enum LocalConstants {
        static let borderWidth: CGFloat = 2
        static let height: CGFloat = 100
    }
    
    @ObservedObject private var viewModel: NutrientsBlockViewModel
    
    init(viewModel: NutrientsBlockViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        actualBody
            .padding(.horizontal, UIConstants.Paddings.xl)
            .padding(.top, UIConstants.Paddings.xs)
            .padding(.bottom, UIConstants.Paddings.xxxs)
            .background(background)
            .frame(height: LocalConstants.height)
    }
    
    @ViewBuilder private var actualBody: some View {
        switch viewModel.contentState {
        case .skeleton:
            skeleton
            
        case .content:
            content
            
        default:
            EmptyView()
        }
    }
    
    private var skeleton: some View {
        VStack {
            NutrientsBlockSkeletonView()
            
            Spacer()
        }
    }
    
    private var content: some View {
        VStack {
            HStack {
                ForEach(viewModel.nutrients, id: \.id) {
                    nutrientElement($0)
                    
                    if !viewModel.nutrients.isLastItem($0) {
                        Spacer()
                    }
                }
                
                if !viewModel.viewMoreTapHandler.isNil {
                    Spacer()
                }
                
                viewMoreButton
            }
            
            Spacer()
            
            Text(String(localized: .nutritionDataIsPerServing))
                .customFont(size: UIConstants.Font.xs)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.accentGray))
        }
    }
    
    private func nutrientElement(_ nutrient: Nutrient) -> some View {
        VStack {
            Text(nutrient.name)
                .customFont(size: UIConstants.Font.s)
            
            Text(nutrient.amount)
                .customFont(size: UIConstants.Font.m)
                .fontWeight(.semibold)
                .foregroundColor(Color(.primaryAccent))
            
            Text(nutrient.unit)
                .customFont(size: UIConstants.Font.xs)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.accentGray))
        }
    }
    
    @ViewBuilder private var viewMoreButton: some View {
        if !viewModel.viewMoreTapHandler.isNil {
            Button(action: viewModel.didTapViewMore) {
                Text(String(localized: .viewMore))
                    .customFont(size: UIConstants.Font.s)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.primaryAccent))
                    .fontWeight(.bold)
                    .frame(maxHeight: .infinity)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: UIConstants.Radius.m)
            .stroke(Color(.accentGray), lineWidth: LocalConstants.borderWidth)
            .foregroundColor(.clear)
    }
}

struct NutrientsBlockView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NutrientsBlockViewModel()
        viewModel.contentState = .content
        viewModel.viewMoreTapHandler = {}
        viewModel.nutrients = [
            Nutrient(
                name: "Calories",
                amount: "543.36",
                unit: "kcal",
                percentOfDailyNeeds: 0
            ),
            Nutrient(
                name: "Fat",
                amount: "16.2",
                unit: "g",
                percentOfDailyNeeds: 0
            ),
            Nutrient(
                name: "Protein",
                amount: "16.84",
                unit: "g",
                percentOfDailyNeeds: 0
            )
        ]
        
        return NutrientsBlockView(viewModel: viewModel)
    }
}
