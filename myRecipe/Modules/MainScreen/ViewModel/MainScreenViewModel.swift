//
//  MainScreenViewModel.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import Foundation

final class MainScreenViewModel {
    private let viewState: MainScreenViewState
    private weak var output: MainScreenOutput?

    init(
        viewState: MainScreenViewState,
        output: MainScreenOutput
    ) {
        self.viewState = viewState
        self.output = output
        
        setupCarousel()
    }
    
    private func setupCarousel() {
        viewState.carouselViewModel.cells = ApiConstants.AvailableMealTypes.allCases.map {
            SingleSelectionCarouselCellViewModel(
                text: $0.rawValue.capitalizingFirstLetter(),
                tapHandler: didTapCarouselCell
            )
        }
        
        viewState.carouselViewModel.cells.first?.isSelected = true
    }
    
    private func didTapCarouselCell(text: String) {
        print(text)
        
        viewState.carouselViewModel.cells.forEach {
            if $0.isSelected {
                $0.isSelected = false
            }
            
            if $0.text == text {
                $0.isSelected = true
                viewState.carouselViewModel.currentSelectedId.send($0.id)
            }
        }
    }
}

// MARK: - MainScreenInput

extension MainScreenViewModel: MainScreenInput {}

// MARK: - MainScreenViewOutput

extension MainScreenViewModel: MainScreenViewOutput {}
