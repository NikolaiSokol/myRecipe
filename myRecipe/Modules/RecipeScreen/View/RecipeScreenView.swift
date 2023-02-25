//
//  RecipeScreenView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import SwiftUI

struct RecipeScreenView: View {
    private enum LocalConstants {
        static let imageMaxWidth = UIScreen.main.bounds.width
        static let imageMaxHeight = UIScreen.main.bounds.height / 2
        static let summaryNameSpace = "RecipeScreenViewSummaryNameSpace"
        static let collapsedSummaryLineLimit = 4
        static let summaryMaxHeightForCollapsing: CGFloat = 100
        static let measureToggleWidth = UIScreen.main.bounds.width / 3
    }
    
    @ObservedObject private var state: RecipeScreenViewState
    private let output: RecipeScreenViewOutput
    
    @State private var measureSystem: MeasureType = .us
    @State private var summaryLineLimit: Int?
    @State private var isShowingSummaryCollapseButton = false
    
    init(
        state: RecipeScreenViewState,
        output: RecipeScreenViewOutput
    ) {
        self.state = state
        self.output = output
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(.primaryAccent).opacity(0.8))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            scrollContent
        }
    }
    
    private var scrollContent: some View {
        VStack(alignment: .leading, spacing: .zero) {
            image
            
            title
            
            summary
            
            ingredients
            
            instructions
            
            Spacer(minLength: UIConstants.Paddings.s)
        }
    }
    
    private var image: some View {
        // swiftlint:disable:next multiline_arguments
        AsyncImage(url: state.recipe.imageUrl) {
            $0.resizable()
        } placeholder: {
            imagePlaceholder
        }
        .scaledToFit()
        .frame(maxWidth: LocalConstants.imageMaxWidth, maxHeight: LocalConstants.imageMaxHeight)
    }
    
    private var imagePlaceholder: some View {
        ZStack {
            Color(.accentGray)
            
            Image(.placeholder)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: LocalConstants.imageMaxWidth, maxHeight: LocalConstants.imageMaxHeight)
                .opacity(0.5)
        }
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: UIConstants.Paddings.xxs) {
            Text(state.recipe.title)
                .customFont(size: UIConstants.Font.xxl)
                .fontWeight(.semibold)
            
            separator
        }
        .padding(.top, UIConstants.Paddings.m)
        .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    @ViewBuilder private var summary: some View {
        if !state.recipe.summary.isEmpty {
            VStack(alignment: .leading, spacing: UIConstants.Paddings.xxxs) {
                Text(state.recipe.summary)
                    .customFont(size: UIConstants.Font.s)
                    .foregroundColor(Color(.textAccent))
                    .textSelection(.enabled)
                    .lineLimit(summaryLineLimit)
                    .multilineTextAlignment(.leading)
                    .modifier(if: !state.didMeasureSummaryHeight) {
                        $0.onFrameChanged(in: LocalConstants.summaryNameSpace, perform: onSummaryFrameChanges)
                    }
                
                summaryCollapsingButton
                
                recipeShortInfo
                
                separator
                    .padding(.top, UIConstants.Paddings.s)
            }
            .padding(.top, UIConstants.Paddings.s)
            .padding(.horizontal, UIConstants.Paddings.s)
        }
    }
    
    @ViewBuilder private var summaryCollapsingButton: some View {
        if isShowingSummaryCollapseButton {
            Button(action: toggleSummaryCollapsing) {
                HStack {
                    Spacer()
                    
                    Text(summaryLineLimit.isNil ? String(localized: .collapse) : String(localized: .expand))
                        .customFont(size: UIConstants.Font.xs)
                        .foregroundColor(Color(.primaryAccent))
                        .bold()
                }
            }
            .buttonStyle(.plain)
        }
    }
    
    private var recipeShortInfo: some View {
        HStack {
            RecipeShortInfoView(type: .cookTime, text: state.recipe.readyInMinutes)
            
            RecipeShortInfoView(type: .serves, text: state.recipe.servings)
            
            if let origin = state.recipe.cuisines.first {
                RecipeShortInfoView(type: .cuisine, text: origin.capitalizingFirstLetter())
            } else if let dishType = state.recipe.dishTypes.first {
                RecipeShortInfoView(type: .perfectFor, text: dishType.capitalizingFirstLetter())
            }
        }
        .padding(.top, UIConstants.Paddings.s)
    }
    
    @ViewBuilder private var ingredients: some View {
        if !state.recipe.ingredients.isEmpty {
            VStack(alignment: .leading, spacing: .zero) {
                HStack {
                    sectionTitle(text: String(localized: .ingredients))
                    
                    Spacer()
                    
                    measureToggle
                }
                
                ForEach(state.recipe.ingredients, id: \.id) {
                    IngredientRowView(ingredient: $0, measureType: measureSystem)
                        .padding(.bottom, UIConstants.Paddings.xxs)
                }
                
                separator
                    .padding(.top, UIConstants.Paddings.s)
            }
            .padding(.horizontal, UIConstants.Paddings.s)
        }
    }
    
    private var measureToggle: some View {
        Picker("", selection: $measureSystem) {
            ForEach(MeasureType.allCases, id: \.self) {
                Text($0.rawValue)
                    .customFont(size: UIConstants.Font.s)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: LocalConstants.measureToggleWidth)
    }
    
    @ViewBuilder private var instructions: some View {
        if !state.recipe.steps.isEmpty {
            VStack(alignment: .leading, spacing: .zero) {
                sectionTitle(text: String(localized: .instructions))
                
                ForEach(state.recipe.steps, id: \.number) {
                    InstructionRowView(step: $0)
                        .padding(.bottom, UIConstants.Paddings.xs)
                }
                
                separator
            }
            .padding(.horizontal, UIConstants.Paddings.s)
        }
    }
    
    private var separator: some View {
        Rectangle()
            .foregroundColor(Color(.separator))
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
    
    private func sectionTitle(text: String) -> some View {
        Text(text)
            .customFont(size: UIConstants.Font.l)
            .padding(.vertical, UIConstants.Paddings.s)
            .fontWeight(.semibold)
    }
    
    private func toggleSummaryCollapsing() {
        withAnimation {
            if summaryLineLimit.isNil {
                summaryLineLimit = LocalConstants.collapsedSummaryLineLimit
            } else {
                summaryLineLimit = nil
            }
        }
    }
    
    private func onSummaryFrameChanges(frame: CGRect) {
        state.didMeasureSummaryHeight = true
        
        if frame.height > LocalConstants.summaryMaxHeightForCollapsing {
            summaryLineLimit = LocalConstants.collapsedSummaryLineLimit
            isShowingSummaryCollapseButton = true
        }
    }
}
