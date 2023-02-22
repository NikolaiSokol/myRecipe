//
//  SingleSelectionCarouselCellView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import SwiftUI

struct SingleSelectionCarouselCellView: View {
    @ObservedObject private var viewModel: SingleSelectionCarouselCellViewModel
    
    init(viewModel: SingleSelectionCarouselCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(action: viewModel.didTapCell) {
            text
                .background(background)
        }
        .buttonStyle(.plain)
    }
    
    private var text: some View {
        Text(viewModel.text)
            .lineLimit(1)
            .foregroundColor(
                viewModel.isSelected ?
                Color("primaryAccent") : Color("textAccent")
            )
            .font(.custom("Poppins", size: UIConstants.Font.s))
            .fontWeight(.medium)
            .padding(.vertical, UIConstants.Paddings.xs)
            .padding(.horizontal, UIConstants.Paddings.s)
    }
    
    private var background: some View {
        Rectangle()
            .foregroundColor(
                viewModel.isSelected ?
                Color("primaryLightAccent") : Color("secondaryGray")
            )
            .cornerRadius(UIConstants.Radius.s)
    }
}

struct SingleSelectionCarouselCellView_Previews: PreviewProvider {
    // swiftlint:disable trailing_closure
    static var previews: some View {
        SingleSelectionCarouselCellView(
            viewModel: SingleSelectionCarouselCellViewModel(
                text: "Breakfast",
                tapHandler: { _ in }
            )
        )
    }
}
