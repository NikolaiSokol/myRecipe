//
//  SearchBoxPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation
import Combine

final class SearchBoxPresenter {
    private let viewState: SearchBoxViewState
    private weak var output: SearchBoxOutput?
    
    private var textChangesSubscription: AnyCancellable?
    private var didBecomeFocusedSubscription: AnyCancellable?
    
    private var shouldReactToTextChanges = true

    init(
        viewState: SearchBoxViewState,
        output: SearchBoxOutput
    ) {
        self.viewState = viewState
        self.output = output
    }
    
    private func subscribeToTextChanges() {
        textChangesSubscription = viewState.$text
            .dropFirst()
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                
                if self.shouldReactToTextChanges {
                    self.output?.searchBoxDidRequest(
                        event: .textChanged($0.trimmingCharacters(in: .whitespacesAndNewlines))
                    )
                } else {
                    self.shouldReactToTextChanges = true
                }
            }
    }
    
    private func subscribeToDidBecomeFocused() {
        didBecomeFocusedSubscription = viewState.didBecomeFocusedSubject
            .sink { [weak self] in
                self?.output?.searchBoxDidRequest(event: .textFieldBecameFocused)
            }
    }
}

// MARK: - SearchBoxInput

extension SearchBoxPresenter: SearchBoxInput {
    func configure() {
        subscribeToTextChanges()
        subscribeToDidBecomeFocused()
    }
    
    func endEditing() {
        viewState.endEditing()
    }
    
    func getText() -> String {
        viewState.text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func updateText(_ text: String) {
        shouldReactToTextChanges = false
        viewState.text = text
    }
}

// MARK: - SearchBoxViewOutput

extension SearchBoxPresenter: SearchBoxViewOutput {
    func didTapReturnKey() {
        output?.searchBoxDidRequest(event: .returnKeyTapped)
    }
}
