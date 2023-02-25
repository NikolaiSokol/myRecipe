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
        static let imageMaxHeight = UIScreen.main.bounds.height / 3
        static let summaryNameSpace = "RecipeScreenViewSummaryNameSpace"
        static let collapsedSummaryLineLimit = 4
        static let summaryMaxHeightForCollapsing: CGFloat = 100
    }
    
    @ObservedObject private var state: RecipeScreenViewState
    private let output: RecipeScreenViewOutput
    
    @State private var summaryLineLimit: Int?
    @State private var isShowingSummaryCollapseButton = false
    
    init(
        state: RecipeScreenViewState,
        output: RecipeScreenViewOutput
    ) {
        self.state = state
        self.output = output
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
            
//            sectionTitle(text: "instructions".localized())
            
            Spacer(minLength: UIConstants.Paddings.s)
        }
    }
    
    private var image: some View {
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
            Color("accentGray")
            
            Image("placeholder")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: LocalConstants.imageMaxWidth, maxHeight: LocalConstants.imageMaxHeight)
                .opacity(0.5)
        }
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: UIConstants.Paddings.xxs) {
            Text(state.recipe.title)
                .font(.custom("Poppins", size: UIConstants.Font.xxl))
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
                    .font(.custom("Poppins", size: UIConstants.Font.s))
                    .foregroundColor(Color("textAccent"))
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
                    
                    Text(summaryLineLimit.isNil ? "collapse".localized() : "expand".localized())
                        .font(.custom("Poppins", size: UIConstants.Font.xs))
                        .foregroundColor(Color("primaryAccent"))
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
    
    private var ingredients: some View {
        VStack(spacing: .zero) {
            sectionTitle(text: "ingredients".localized())
            
            
        }
    }
    
    private var separator: some View {
        Rectangle()
            .foregroundColor(Color("separator"))
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
    
    private func sectionTitle(text: String) -> some View {
        Text(text)
            .font(.custom("Poppins", size: UIConstants.Font.l))
            .padding(.vertical, UIConstants.Paddings.m)
            .fontWeight(.semibold)
            .padding(.horizontal, UIConstants.Paddings.s)
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
