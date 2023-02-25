//
//  ErrorView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 22.02.2023.
//

import SwiftUI

struct ErrorView: View {
    private enum LocalConstants {
        static let imageWidth = UIScreen.main.bounds.width / 2
        static let buttonHeight: CGFloat = 50
    }
    
    private let viewModel: ErrorViewModel
    
    init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            image
            
            title
            
            subTitle
            
            actionButton
        }
    }
    
    private var image: some View {
        Image(systemName: "exclamationmark.icloud")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: LocalConstants.imageWidth)
            .foregroundColor(Color(.accentGray))
    }
    
    @ViewBuilder private var title: some View {
        if let title = viewModel.title {
            Text(title)
                .customFont(size: UIConstants.Font.l)
                .fontWeight(.semibold)
                .padding(.top, UIConstants.Paddings.xl)
        }
    }
    
    @ViewBuilder private var subTitle: some View {
        if let subTitle = viewModel.subtitle {
            Text(subTitle)
                .customFont(size: UIConstants.Font.m)
                .padding(.top, UIConstants.Paddings.xxs)
        }
    }
    
    @ViewBuilder private var actionButton: some View {
        if !viewModel.buttonAction.isNil {
            Button(action: viewModel.didTapActionButton) {
                actionButtonLabel
            }
            .buttonStyle(.plain)
        }
    }
    
    private var actionButtonLabel: some View {
        Rectangle()
            .foregroundColor(Color(.primaryAccent))
            .frame(height: LocalConstants.buttonHeight)
            .cornerRadius(UIConstants.Radius.m)
            .overlay {
                actionButtonText
            }
            .padding(.horizontal, UIConstants.Paddings.s)
            .padding(.top, UIConstants.Paddings.xl)
    }
    
    @ViewBuilder private var actionButtonText: some View {
        if let buttonText = viewModel.buttonText {
            Text(buttonText)
                .customFont(size: UIConstants.Font.m)
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            viewModel: ErrorViewModel(
                title: "Something went wrong",
                subtitle: "We're sorry. Please, check your connection",
                buttonText: "Try again") {}
        )
    }
}
