//
//  SortingView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import SwiftUI

struct SortingView: View {
    private enum LocalConstants {
        static let contentNameSpace = "SortingViewContentNameSpace"
        static let radioButtonSize: CGFloat = 25
    }
    
    @ObservedObject private var viewModel: SortingViewModel
    @Binding private var contentSize: CGSize
    
    init(
        viewModel: SortingViewModel,
        contentSize: Binding<CGSize>
    ) {
        self.viewModel = viewModel
        _contentSize = contentSize
    }
    
    var body: some View {
        VStack(spacing: UIConstants.Paddings.xs) {
            Text(String(localized: .sort))
                .customFont(size: UIConstants.Font.l)
                .fontWeight(.semibold)
                .padding(.vertical, UIConstants.Paddings.xxs)
            
            options
            
            Spacer()
                .frame(height: UIConstants.Paddings.s)
        }
        .padding(.top, UIConstants.Paddings.m)
        .getViewSize($contentSize, spaceName: LocalConstants.contentNameSpace)
    }
    
    private var options: some View {
        ForEach(viewModel.options, id: \.id) { option in
            Button {
                viewModel.didTapSortingOption(option)
            } label: {
                optionRow(option)
            }
            .buttonStyle(.plain)
        }
    }
    
    @ViewBuilder private func optionRow(_ option: SortingOption) -> some View {
        let isSelected = option == viewModel.selectedOption
        
        VStack(spacing: UIConstants.Paddings.xxs) {
            HStack {
                Text(option.localizedString().capitalizingFirstLetter())
                    .customFont(size: UIConstants.Font.m)
                    .modifier(if: isSelected) {
                        $0.fontWeight(.semibold)
                    }
                
                Spacer()
                
                radioButton(isSelected: isSelected)
            }
            .contentShape(Rectangle())
            
            if !viewModel.options.isLastItem(option) {
                Separator()
            }
        }
    }
    
    private func radioButton(isSelected: Bool) -> some View {
        Circle()
            .stroke(Color(.accentGray), lineWidth: 1)
            .frame(height: LocalConstants.radioButtonSize)
            .modifier(if: isSelected) {
                $0.overlay {
                    Circle()
                        .foregroundColor(Color(.primaryAccent))
                        .padding(UIConstants.Paddings.xxxs)
                }
            }
    }
}

struct SortingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SortingViewModel()
        viewModel.options = SortingOption.allCases
        viewModel.tapHandler = { _ in }
        
        return SortingView(
            viewModel: viewModel,
            contentSize: .constant(.zero)
        )
    }
}
