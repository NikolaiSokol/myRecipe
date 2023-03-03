//
//  SettingsScreenRootView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

struct SettingsScreenRootView: View {
    private enum LocalConstants {
        static let measureToggleWidth = UIScreen.main.bounds.width / 3
    }
    
    @ObservedObject private var state: SettingsScreenRootViewState
    @ObservedObject private var router: Router
    
    private weak var output: SettingsScreenRootViewOutput?
    
    @State private var isShowingIntolerancesSelection = false
    
    init(
        state: SettingsScreenRootViewState,
        router: Router,
        output: SettingsScreenRootViewOutput
    ) {
        self.state = state
        self.router = router
        self.output = output
    }
    
    var body: some View {
        NavigationStack(path: $router.navigableViews) {
            actualBody
                .navigationDestination(for: NavigableView.self) {
                    $0.view
                }
                .navigationTitle(String(localized: .settings))
                .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $isShowingIntolerancesSelection) {
            MultiSelectView(
                title: String(localized: .intolerances),
                items: state.intolerances,
                selections: $state.chosenIntolerances
            )
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .padding(.horizontal, UIConstants.Paddings.s)
        }
    }
    
    private var actualBody: some View {
        Form {
            measureSystem

            intolerances
        }
    }
    
    private var measureSystem: some View {
        Section {
            makeRow(title: String(localized: .measureSystem)) {
                Picker("", selection: $state.chosenMeasureSystem) {
                    ForEach(MeasureSystem.allCases, id: \.id) {
                        Text($0.localizedString())
                            .customFont(size: UIConstants.Font.s)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: LocalConstants.measureToggleWidth)
            }
        }
    }
    
    private var intolerances: some View {
        Section(
            footer: Text(String(localized: .intolerancesSettingsDescription))
        ) {
            makeRow(title: String(localized: .intolerances)) {
                Button(action: didTapShowIntolerances) {
                    Text(
                        state.chosenIntolerances.isEmpty ?
                        String(localized: .select) : joinedIntolerances()
                    )
                    .customFont(size: UIConstants.Font.m)
                    .lineLimit(1)
                }
            }
        }
    }
    
    private func makeRow(
        title: String,
        @ViewBuilder content: () -> some View
    ) -> some View {
        VStack(spacing: UIConstants.Paddings.xxs) {
            HStack {
                Text(title)
                    .customFont(size: UIConstants.Font.m)
                    .lineLimit(1)
                
                Spacer()
                
                content()
            }
        }
    }
    
    private func didTapShowIntolerances() {
        isShowingIntolerancesSelection = true
    }
    
    private func joinedIntolerances() -> String {
        state.chosenIntolerances
            .sorted { $0 < $1 }
            .map { $0.localizedString() }
            .joined(separator: ", ")
    }
}
