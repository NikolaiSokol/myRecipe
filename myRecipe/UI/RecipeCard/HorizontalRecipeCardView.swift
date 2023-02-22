//
//  HorizontalRecipeCardView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 20.02.2023.
//

import SwiftUI

struct HorizontalRecipeCardView: View {
    private enum LocalConstants {
        static let height: CGFloat = 200
        static let titleSize: CGFloat = 22
        static let secondaryElementsSize: CGFloat = 16
        static let saveButtonSize: CGFloat = 40
    }
    
    @ObservedObject private var viewModel: HorizontalRecipeCardViewModel
    
    init(viewModel: HorizontalRecipeCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(action: viewModel.didTapRecipeCard) {
            image
                .overlay {
                    content
                }
                .cornerRadius(UIConstants.Radius.l)
        }
        .buttonStyle(.plain)
    }
    
    private var image: some View {
        AsyncImage(url: viewModel.imageUrl) {
            $0.resizable()
        } placeholder: {
            imagePlaceholder
        }
        .scaledToFill()
        .frame(height: LocalConstants.height)
        .frame(maxWidth: .infinity)
    }
    
    private var imagePlaceholder: some View {
        ZStack {
            Color("accentGray")
            
            Image("placeholder")
                .resizable()
                .scaledToFit()
                .frame(height: LocalConstants.height)
                .padding(.top, UIConstants.Paddings.xl)
                .opacity(0.5)
        }
    }
    
    private var content: some View {
        VStack {
            saveButton
            
            Spacer()
            
            titleWithTimeToCook
        }
    }
    
    private var saveButton: some View {
        HStack {
            Spacer()
            
            Button(action: viewModel.didTapSaveButton) {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color("accentGray"), .clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: 25
                        )
                    )
                    .frame(height: LocalConstants.saveButtonSize)
                    .overlay {
                        Image(systemName: viewModel.isSaved ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: LocalConstants.secondaryElementsSize)
                    }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, UIConstants.Paddings.s)
        .padding(.top, UIConstants.Paddings.xxs)
    }
    
    private var titleWithTimeToCook: some View {
        HStack {
            VStack(alignment: .leading, spacing: .zero) {
                title
                
                timeToCook
            }
            .padding(.vertical, UIConstants.Paddings.xxs)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, UIConstants.Paddings.s)
        .background(gradientBackground)
    }
    
    private var title: some View {
        Text(viewModel.name)
            .foregroundColor(.white)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .font(.custom("Poppins", size: LocalConstants.titleSize))
            .bold()
    }
    
    private var timeToCook: some View {
        HStack {
            Image(systemName: "clock")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(height: LocalConstants.secondaryElementsSize)
            
            Text(viewModel.timeToCook)
                .foregroundColor(.white)
                .font(.custom("Poppins", size: LocalConstants.secondaryElementsSize))
                .fontWeight(.semibold)
        }
    }
    
    private var gradientBackground: some View {
        LinearGradient(
            colors: [.clear, .black],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRecipeCardView(
            viewModel: HorizontalRecipeCardViewModel(
                id: 1,
                imageUrl: URL(string: "https://spoonacular.com/recipeImages/721059-556x370.jpg"),
                name: "Blueberry Almond Crescent Rolls",
                timeToCook: "45 min",
                recipeCardTapHandler: { _ in print("card tapped") },
                saveButtonTapHandler: { print("save tapped") }
            )
        )
    }
}
