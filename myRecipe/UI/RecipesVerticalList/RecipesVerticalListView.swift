//
//  RecipesVerticalListView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import SwiftUI
import Combine

struct RecipesVerticalListView: View {
    private enum LocalConstants {
        static let topAnchorHeight: CGFloat = 1
        static let topAnchorId = "RecipesVerticalListViewTopAnchorId"
        static let scrollNameSpace = "RecipesVerticalListViewNameSpace"
    }
    
    @ObservedObject private var viewModel: RecipesVerticalListViewModel
    
    init(viewModel: RecipesVerticalListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollViewReader { scrollReader in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    topAnchor
                    
                    scrollContent
                    
                    pagination
                    
                    Spacer(minLength: UIConstants.Paddings.s)
                }
                .background(scrollOffsetReader)
            }
            .modifier(
                if: viewModel.isRefreshable && viewModel.contentState.isContent()
            ) {
                $0.refreshable {
                    viewModel.refresh()
                }
            }
            .onReceive(viewModel.scrollToTopSubject) {
                withAnimation {
                    scrollReader.scrollTo(LocalConstants.topAnchorId)
                }
            }
            .coordinateSpace(name: LocalConstants.scrollNameSpace)
        }
    }
    
    private var topAnchor: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: LocalConstants.topAnchorHeight)
            .id(LocalConstants.topAnchorId)
    }
    
    @ViewBuilder private var scrollContent: some View {
        switch viewModel.contentState {
        case .skeleton:
            skeleton
            
        case .content:
            content
            
        case .error:
            errorScreen
        }
    }
    
    private var skeleton: some View {
        ForEach(0 ..< 3) { _ in
            HorizontalRecipeCardSkeletonView()
        }
    }
    
    private var content: some View {
        ForEach(viewModel.cards, id: \.id) { card in
            HorizontalRecipeCardView(viewModel: card)
                .onAppear {
                    viewModel.onCardAppear(id: card.id)
                }
        }
    }
    
    @ViewBuilder private var errorScreen: some View {
        if let model = viewModel.errorViewModel {
            ErrorView(viewModel: model)
                .padding(.top, UIConstants.Paddings.xl)
        }
    }
    
    @ViewBuilder private var pagination: some View {
        if viewModel.isLoadingNextPage {
            HorizontalRecipeCardSkeletonView()
        }
    }
    
    private var scrollOffsetReader: some View {
        GeometryReader { proxy -> AnyView in
            let offset = proxy.frame(in: .named(LocalConstants.scrollNameSpace)).origin.y
            
            if viewModel.scrollOffsetSubject.value != offset {
                viewModel.scrollOffsetSubject.value = offset
            }
            
            return Color.clear.eraseToAnyView()
        }
    }
}

struct RecipesVerticalListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesVerticalListView(
            viewModel: RecipesVerticalListViewModel()
        )
    }
}
