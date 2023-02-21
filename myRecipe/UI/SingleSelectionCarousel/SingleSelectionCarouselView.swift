//
//  SingleSelectionCarouselView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 21.02.2023.
//

import SwiftUI

struct SingleSelectionCarouselView: View {
    @ObservedObject private var viewModel: SingleSelectionCarouselViewModel
    
    private let horizontalInsets: CGFloat
    
    init(
        viewModel: SingleSelectionCarouselViewModel,
        horizontalInsets: CGFloat
    ) {
        self.viewModel = viewModel
        self.horizontalInsets = horizontalInsets
    }
    
    var body: some View {
        ScrollViewReader { scrollReader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.cells) {
                        let cellIndex = viewModel.cells.firstIndex(of: $0) ?? 0
                        
                        SingleSelectionCarouselCellView(viewModel: $0)
                            .id($0.id)
                            .modifier(if: cellIndex.isZero) {
                                $0.padding(.leading, horizontalInsets)
                            }
                            .modifier(if: cellIndex == viewModel.cells.count - 1) {
                                $0.padding(.trailing, horizontalInsets)
                            }
                    }
                }
            }
            .onReceive(viewModel.currentSelectedId) { id in
                withAnimation {
                    scrollReader.scrollTo(id, anchor: .center)
                }
            }
        }
    }
}

struct SingleSelectionCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SingleSelectionCarouselView(
            viewModel: SingleSelectionCarouselViewModel(),
            horizontalInsets: UIConstants.Paddings.s
        )
    }
}
