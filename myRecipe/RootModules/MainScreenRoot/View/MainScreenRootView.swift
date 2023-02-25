//
//  MainScreenRootView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

struct MainScreenRootView: View {
    private enum LocalConstants {
        static let animationDuration: CGFloat = 0.2
        static let minimumScrollOffsetForShowingTopSection: CGFloat = -20
        static let recipesCountToHideTopSection = 2
    }
    
    @ObservedObject private var state: MainScreenRootViewState
    @ObservedObject private var router: Router
    
    @State private var isShowingTopSection = true
    
    private let output: MainScreenRootViewOutput
    
    init(
        state: MainScreenRootViewState,
        router: Router,
        output: MainScreenRootViewOutput
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
        }
    }
    
    private var actualBody: some View {
        VStack(spacing: .zero) {
            if isShowingTopSection {
                header
                
                searchField
            }
            
            randomRecipesByType
            
            Spacer()
        }
        .onReceive(
            (state.randomRecipesByTypeModel?.viewState.recipesViewModel.scrollOffsetSubject).orEmpty(),
            perform: onRandomRecipesByTypeScrollOffsetChanges
        )
        .onReceive(state.showTopSectionSubject, perform: onReceiveShowTopSection)
        .onTapGesture {
            output.endEditing()
        }
    }
    
    private var header: some View {
        MainScreenHeaderView()
            .padding(.horizontal, UIConstants.Paddings.s)
            .padding(.top, UIConstants.Paddings.xxs)
    }
    
    @ViewBuilder private var searchField: some View {
        if let model = state.searchBoxModel {
            SearchBoxView(state: model.viewState, output: model.viewOutput)
                .padding(.horizontal, UIConstants.Paddings.s)
                .padding(.top, UIConstants.Paddings.m)
        }
    }
    
    @ViewBuilder private var randomRecipesByType: some View {
        if let model = state.randomRecipesByTypeModel {
            RandomRecipesByTypeView(state: model.viewState, output: model.viewOutput)
                .padding(.top, UIConstants.Paddings.s)
        }
    }
    
    private func onRandomRecipesByTypeScrollOffsetChanges(_ offset: CGFloat) {
        guard let recipesModel = state.randomRecipesByTypeModel,
              recipesModel.viewState.recipesViewModel.contentState.isContent(),
              recipesModel.viewState.recipesViewModel.cards.count > LocalConstants.recipesCountToHideTopSection
        else {
            return
        }

        withAnimation(.linear(duration: LocalConstants.animationDuration)) {
            if offset < LocalConstants.minimumScrollOffsetForShowingTopSection, isShowingTopSection {
                isShowingTopSection = false
            } else if offset > LocalConstants.minimumScrollOffsetForShowingTopSection, !isShowingTopSection {
                isShowingTopSection = true
            }
        }
    }
    
    private func onReceiveShowTopSection() {
        withAnimation(.linear(duration: LocalConstants.animationDuration)) {
            isShowingTopSection = true
        }
    }
}
