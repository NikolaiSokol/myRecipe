//
//  FiltersView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import SwiftUI

struct FiltersView: View {
    private enum LocalConstants {
        static let textFieldWidth: CGFloat = 60
        static let textFieldBorderWidth: CGFloat = 2
        static let applyButtonHeight: CGFloat = 50
        static let applyButtonNameSpace = "FiltersViewApplyButtonNameSpace"
    }
    
    @ObservedObject private var viewModel: FiltersViewModel
    
    @State private var isShowingIntolerancesSelection = false
    @State private var applyButtonSize: CGSize = .zero
    
    @FocusState var isTextFieldFocused: Bool
    
    init(viewModel: FiltersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: UIConstants.Paddings.xs) {
                    Text(String(localized: .filters))
                        .customFont(size: UIConstants.Font.l)
                        .fontWeight(.semibold)
                        .padding(.top, UIConstants.Paddings.xxs)
                    
                    clearAllButton
                    
                    content
                    
                    Spacer()
                        .frame(height: applyButtonSize.height + UIConstants.Paddings.s)
                }
            }
            
            applyButton
        }
        .sheet(isPresented: $isShowingIntolerancesSelection) {
            MultiSelectView(
                title: String(localized: .intolerances),
                items: viewModel.intolerances,
                selections: $viewModel.chosenIntolerances
            )
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .padding(.horizontal, UIConstants.Paddings.s)
        }
        .padding(.vertical, UIConstants.Paddings.m)
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
    
    private var content: some View {
        VStack(spacing: UIConstants.Paddings.xxs) {
            instructionsRequired
            
            cuisine
            
            diet
            
            meal
            
            intolerances
            
            maxCalories
        }
    }
    
    private var instructionsRequired: some View {
        makeRow(title: String(localized: .instructionsRequired)) {
            Toggle("", isOn: $viewModel.isInstructionsRequired)
                .padding(.trailing, UIConstants.Paddings.s)
        }
    }
    
    private var cuisine: some View {
        makeRow(title: String(localized: .cuisine).capitalizingFirstLetter()) {
            Picker("", selection: $viewModel.chosenCuisine) {
                ForEach(viewModel.cuisines, id: \.self) {
                    Text($0.localizedString())
                        .customFont(size: UIConstants.Font.s)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    private var diet: some View {
        makeRow(title: String(localized: .diet)) {
            Picker("", selection: $viewModel.chosenDiet) {
                ForEach(viewModel.diets, id: \.self) {
                    Text($0.localizedString())
                        .customFont(size: UIConstants.Font.m)
                }
            }
        }
    }
    
    private var meal: some View {
        makeRow(title: String(localized: .mealType)) {
            Picker("", selection: $viewModel.chosenMeal) {
                ForEach(viewModel.meals, id: \.self) {
                    Text($0.localizedString())
                        .customFont(size: UIConstants.Font.m)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    private var intolerances: some View {
        makeRow(title: String(localized: .intolerances)) {
            Button(action: didTapShowIntolerances) {
                Text(
                    viewModel.chosenIntolerances.isEmpty ?
                    String(localized: .select) : joinedIntolerances()
                )
                .customFont(size: UIConstants.Font.m)
                .lineLimit(1)
            }
            .padding(.trailing, UIConstants.Paddings.s)
        }
    }
    
    private var maxCalories: some View {
        makeRow(title: String(localized: .maximumCalories), withSeparator: false) {
            TextField(String(localized: .amount), text: $viewModel.maxCalories)
                .focused($isTextFieldFocused)
                .keyboardType(.numberPad)
                .frame(maxWidth: LocalConstants.textFieldWidth)
                .padding(UIConstants.Paddings.xxs)
                .overlay {
                    RoundedRectangle(cornerRadius: UIConstants.Radius.xs)
                        .stroke(lineWidth: LocalConstants.textFieldBorderWidth)
                        .foregroundColor(Color(.secondaryGray))
                }
                .padding(.trailing, UIConstants.Paddings.s)
        }
    }
    
    private var clearAllButton: some View {
        HStack {
            Spacer()
            
            Button(action: viewModel.didTapClearAll) {
                Text(String(localized: .clearAll))
                    .customFont(size: UIConstants.Font.s)
                    .fontWeight(.semibold)
            }
            .disabled(viewModel.isClearAllButtonDisabled())
        }
        .padding(.bottom, UIConstants.Paddings.xs)
    }
    
    @ViewBuilder private var applyButton: some View {
        if viewModel.isShowingApplyButton() {
            VStack {
                Spacer()
                
                Button(action: viewModel.didTapApplyButton) {
                    applyButtonContent
                }
                .getViewSize(
                    $applyButtonSize,
                    spaceName: LocalConstants.applyButtonNameSpace
                )
            }
        }
    }
    
    private var applyButtonContent: some View {
        RoundedRectangle(cornerRadius: UIConstants.Radius.m)
            .foregroundColor(Color(.primaryAccent))
            .frame(height: LocalConstants.applyButtonHeight)
            .overlay {
                Text(String(localized: .apply))
                    .customFont(size: UIConstants.Font.l)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
    }
    
    private func makeRow(
        title: String,
        withSeparator: Bool = true,
        @ViewBuilder content: () -> some View
    ) -> some View {
        VStack(spacing: UIConstants.Paddings.xxs) {
            HStack {
                Text(title)
                    .customFont(size: UIConstants.Font.m)
                
                Spacer()
                
                content()
            }
            
            if withSeparator {
                Separator()
            }
        }
    }
    
    private func didTapShowIntolerances() {
        isShowingIntolerancesSelection = true
    }
    
    private func joinedIntolerances() -> String {
        viewModel.chosenIntolerances
            .sorted { $0 < $1 }
            .map { $0.localizedString() }
            .joined(separator: ", ")
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FiltersViewModel()
        viewModel.cuisines = CuisineType.allCases
        viewModel.diets = DietType.allCases
        viewModel.meals = MealType.allCases
        viewModel.intolerances = IntoleranceType.allCases
        
        return FiltersView(viewModel: viewModel)
    }
}
