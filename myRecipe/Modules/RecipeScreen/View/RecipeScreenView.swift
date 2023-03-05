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
        static let defaultSavingPopupOffset: CGFloat = -50
        static let savingPopupOffset: CGFloat = 20
        static let savingPopupShowingTime = 2.0
    }
    
    @ObservedObject private var state: RecipeScreenViewState
    private weak var output: RecipeScreenViewOutput?
    
    @State private var summaryLineLimit: Int?
    @State private var isShowingSummaryCollapseButton = false
    @State private var savingPopupOffset = LocalConstants.defaultSavingPopupOffset
    
    init(
        state: RecipeScreenViewState,
        output: RecipeScreenViewOutput
    ) {
        self.state = state
        self.output = output
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                scrollContent
            }
            
            savingPopup
        }
        .sheet(isPresented: $state.isShowingNutrition) {
            NutrientsView(nutrients: state.recipe.nutrients)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .padding(.horizontal, UIConstants.Paddings.s)
        }
        .toolbar {
            savingButton
        }
        .onReceive(state.shouldShowSavingPopupSubject, perform: showSavingPopup)
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
                .padding(UIConstants.Paddings.xl)
                .frame(maxWidth: LocalConstants.imageMaxWidth, maxHeight: LocalConstants.imageMaxHeight)
                .opacity(0.5)
        }
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: UIConstants.Paddings.xxs) {
            Text(state.recipe.title)
                .customFont(size: UIConstants.Font.xxl)
                .fontWeight(.semibold)
            
            Separator()
        }
        .padding(.top, UIConstants.Paddings.m)
        .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    @ViewBuilder private var summary: some View {
        if !state.recipe.summary.isEmpty {
            VStack(alignment: .leading, spacing: UIConstants.Paddings.xxxs) {
                summaryText
                
                summaryCollapsingButton
                
                recipeShortInfo
                
                nutrients
                
                Separator()
            }
            .padding(.top, UIConstants.Paddings.s)
            .padding(.horizontal, UIConstants.Paddings.s)
        }
    }
    
    private var summaryText: some View {
        Text(state.recipe.summary)
            .customFont(size: UIConstants.Font.s)
            .foregroundColor(Color(.textAccent))
            .textSelection(.enabled)
            .lineLimit(summaryLineLimit)
            .multilineTextAlignment(.leading)
            .modifier(if: !state.didMeasureSummaryHeight) {
                $0.onFrameChanged(in: LocalConstants.summaryNameSpace, perform: onSummaryFrameChanges)
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
    
    private var nutrients: some View {
        NutrientsBlockView(viewModel: state.nutrientBlockViewModel)
            .padding(.vertical, UIConstants.Paddings.xs)
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
                    IngredientRowView(ingredient: $0, measureType: state.measureSystem)
                        .padding(.bottom, UIConstants.Paddings.xxs)
                }
                
                Separator()
                    .padding(.top, UIConstants.Paddings.s)
            }
            .padding(.horizontal, UIConstants.Paddings.s)
        }
    }
    
    private var measureToggle: some View {
        Picker("", selection: $state.measureSystem) {
            ForEach(MeasureSystem.allCases, id: \.id) {
                Text($0.localizedString())
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
                
                Separator()
            }
            .padding(.horizontal, UIConstants.Paddings.s)
        }
    }
    
    @ViewBuilder private var savingButton: some View {
        if let output {
            Button(
                action: state.isRecipeSaved ? output.didTapDeleteRecipe : output.didTapSaveRecipe
            ) {
                Image(systemName: state.isRecipeSaved ? "bookmark.fill" : "bookmark")
            }
        }
    }
    
    @ViewBuilder private var savingPopup: some View {
        Text(String(localized: state.isRecipeSaved ? .recipeSaved : .recipeDeleted))
            .customFont(size: UIConstants.Font.m)
            .foregroundColor(.white)
            .padding(UIConstants.Paddings.xs)
            .background {
                RoundedRectangle(cornerRadius: UIConstants.Radius.l)
                    .foregroundColor(.black)
                    .opacity(0.9)
            }
            .offset(y: savingPopupOffset)
            .opacity(savingPopupOffset > 0 ? 1 : 0)
            .padding(.horizontal, UIConstants.Paddings.m)
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
    
    private func showSavingPopup() {
        withAnimation {
            savingPopupOffset = LocalConstants.savingPopupOffset
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + LocalConstants.savingPopupShowingTime) {
            withAnimation {
                savingPopupOffset = LocalConstants.defaultSavingPopupOffset
            }
        }
    }
}
