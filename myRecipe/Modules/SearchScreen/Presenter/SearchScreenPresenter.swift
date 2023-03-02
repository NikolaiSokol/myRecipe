//
//  SearchScreenPresenter.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import Foundation
import Combine

final class SearchScreenPresenter {
    private enum LocalConstants {
        static let recipesToLoad = 16
        static let autocompletesToLoad = 10
        static let delayBeforeHidingSheet = 0.1
    }
    
    private let viewState: SearchScreenViewState
    private weak var output: SearchScreenOutput?
    private let modulesFactory: ModulesFactoring
    private let searchService: SearchServicing
    private let userDefaultsService: UserDefaultsServicing
    
    private var searchBoxInput: SearchBoxInput?
    
    private var autocompleteLoadingTask: Task<Void, Never>?
    private var recipesLoadingTask: Task<Void, Never>?
    
    private var recipeCardAppearedSubscription: AnyCancellable?
    private var searchHistorySubscription: AnyCancellable?
    
    private var searchQuery = ""
    private var recipes: [Recipe] = []
    private var totalResults = 0
    private var selectedSorting: SortingOption = .default
    private var appliedFilters = AppliedFilters.default

    init(
        viewState: SearchScreenViewState,
        output: SearchScreenOutput,
        modulesFactory: ModulesFactoring,
        searchService: SearchServicing,
        userDefaultsService: UserDefaultsServicing
    ) {
        self.viewState = viewState
        self.output = output
        self.modulesFactory = modulesFactory
        self.searchService = searchService
        self.userDefaultsService = userDefaultsService
    }
    
    private func setupSearchBox() {
        let unit = modulesFactory.makeSearchBox(output: self)
        
        searchBoxInput = unit.input
        searchBoxInput?.configure()
        
        viewState.searchBoxModel = unit.model
    }
    
    private func setupSearchSuggestions() {
        viewState.suggestionsViewModel.tapHandler = { [weak self] in
            self?.handleSearchSuggestionTapped(text: $0)
        }
        
        viewState.suggestionsViewModel.clearAllHistoryHandler = { [weak self] in
            self?.handleClearSearchHistoryTapped()
        }
        
        viewState.suggestionsViewModel.clearHistorySuggestionHandler = { [weak self] in
            self?.handleClearSearchHistorySuggestionTapped(text: $0)
        }
    }
    
    private func setupSortingAndFilters() {
        viewState.sortingViewModel.options = SortingOption.allCases
        viewState.sortingViewModel.tapHandler = handleSortingTypeSelected
        
        viewState.filtersViewModel.cuisines = CuisineType.allCases
        viewState.filtersViewModel.diets = DietType.allCases
        viewState.filtersViewModel.meals = MealType.allCases
        viewState.filtersViewModel.intolerances = IntoleranceType.allCases
        
        viewState.showSortingTapHandler = handleShowSortingTapped
        viewState.showFiltersTapHandler = handleShowFiltersTapped
        
        viewState.filtersViewModel.applyButtonHandler = handleApplyFiltersButtonTapped
        
        setSortingAndFiltersToDefault()
    }
    
    private func setSortingAndFiltersToDefault() {
        selectedSorting = .default
        
        appliedFilters = .default
        appliedFilters.intolerances = userDefaultsService.getIntolerances()
    }
    
    private func subscribeToRecipeCardAppeared() {
        recipeCardAppearedSubscription = viewState.recipesViewModel
            .recipeCardAppearedSubject
            .sink { [weak self] in
                self?.recipeCardAppeared(id: $0)
            }
    }
    
    private func subscribeToSearchHistoryChanges() {
        searchHistorySubscription = userDefaultsService
            .listenSearchHistory()
            .sink { [weak self] in
                self?.updateSearchHistory($0)
            }
    }
    
    // MARK: - Autocomplete Loading
    
    private func loadAutocomplete(query: String) {
        autocompleteLoadingTask = Task {
            do {
                let result = try await searchService.loadAutocomplete(
                    query: query.lowercased(),
                    number: LocalConstants.autocompletesToLoad
                )
                
                await updateAutocompletes(result)
                
            } catch {
                ErrorLogger.shared.log(error)
            }
            
            autocompleteLoadingTask = nil
        }
    }
    
    // MARK: - Recipes Loading
    
    private func runSearch() {
        viewState.recipesViewModel.updateContentState(to: .skeleton)
        viewState.recipesViewModel.updateIsLoadingNextPage(to: false)
        viewState.recipesViewModel.cards.removeAll()
        viewState.updateIsShowingSortAndFiltersButtons(to: false)
        
        recipes.removeAll()
        
        userDefaultsService.addToSearchHistory(text: searchQuery)
        
        loadRecipes(offset: 0)
    }
    
    private func loadRecipes(offset: Int) {
        guard recipesLoadingTask.isNil else {
            return
        }
        
        let params = SearchParameters(
            query: searchQuery.lowercased(),
            offset: offset,
            number: LocalConstants.recipesToLoad,
            sorting: selectedSorting,
            filters: appliedFilters
        )
        
        recipesLoadingTask = Task {
            do {
                let results = try await searchService.search(params: params)
                
                if results.totalResults.isZero {
                    await showNoResultsScreen()
                } else {
                    totalResults = results.totalResults
                    
                    await updateRecipes(results.recipes)
                }
                
            } catch {
                ErrorLogger.shared.log(error)
                
                await showErrorScreen()
            }
            
            recipesLoadingTask = nil
        }
    }
    
    // MARK: - UI Updates
    
    @MainActor private func updateAutocompletes(_ autocompletes: [SearchAutocomplete]) {
        guard !autocompletes.isEmpty else {
            viewState.suggestionsViewModel.autocompletes.removeAll()
            return
        }
        
        viewState.suggestionsViewModel.autocompletes = autocompletes
    }
    
    @MainActor private func updateRecipes(_ recipes: [Recipe]) {
        self.recipes.append(contentsOf: recipes)
        
        let cards = recipes.map {
            HorizontalRecipeCardViewModel(
                id: $0.id,
                imageUrl: $0.imageUrl,
                name: $0.title.capitalizingFirstLetter(),
                timeToCook: $0.readyInMinutes,
                recipeCardTapHandler: handleRecipeCardTapped
            )
        }
        
        viewState.recipesViewModel.cards.append(contentsOf: cards)
        viewState.recipesViewModel.isRefreshable = false
        viewState.recipesViewModel.updateContentState(to: .content)
        viewState.recipesViewModel.updateIsLoadingNextPage(to: false)
        viewState.updateIsShowingSortAndFiltersButtons(to: true)
    }
    
    private func updateSearchHistory(_ searches: [String]) {
        let historySearches = searches.map {
            SearchAutocomplete(
                id: searches.firstIndex(of: $0) ?? 0,
                text: $0
            )
        }
        
        viewState.suggestionsViewModel.historySearches = historySearches
    }
    
    // MARK: - Error Screen
    
    @MainActor private func showErrorScreen() {
        let viewModel = ErrorViewModel(
            title: String(localized: .somethingWentWrong),
            buttonText: String(localized: .tryAgain)
        ) { [weak self] in
                self?.runSearch()
                self?.viewState.recipesViewModel.errorViewModel = nil
            }
        
        setErrorScreen(viewModel: viewModel)
    }
    
    @MainActor private func showNoResultsScreen() {
        let viewModel = ErrorViewModel(
            title: String(localized: .notFound),
            subtitle: String(localized: .weAreSorry),
            buttonText: nil,
            buttonAction: nil
        )
        
        setErrorScreen(viewModel: viewModel)
    }
    
    private func setErrorScreen(viewModel: ErrorViewModel) {
        viewState.recipesViewModel.errorViewModel = viewModel
        viewState.recipesViewModel.updateContentState(to: .error)
        viewState.recipesViewModel.updateIsLoadingNextPage(to: false)
        viewState.updateIsShowingSortAndFiltersButtons(to: false)
    }
    
    // MARK: - Tap Handlers
    
    private func handleSearchSuggestionTapped(text: String) {
        searchBoxInput?.endEditing()
        searchQuery = text
        viewState.updateIsShowingSearchSuggestions(to: false)
        
        searchBoxInput?.updateText(text.capitalizingFirstLetter())
        
        setSortingAndFiltersToDefault()
        runSearch()
    }
    
    private func handleClearSearchHistoryTapped() {
        userDefaultsService.clearSearchHistory()
    }
    
    private func handleClearSearchHistorySuggestionTapped(text: String) {
        userDefaultsService.removeItemFromSearchHistory(text: text)
    }
    
    private func handleRecipeCardTapped(id: Int) {
        guard let recipe = recipes.first(where: { $0.id == id }) else {
            return
        }
        
        output?.searchScreenDidRequest(event: .openRecipe(recipe))
    }
    
    private func handleShowSortingTapped() {
        viewState.sortingViewModel.selectedOption = selectedSorting
        
        viewState.isShowingSorting = true
    }
    
    private func handleShowFiltersTapped() {
        viewState.filtersViewModel.isInstructionsRequired = appliedFilters.instructionsRequired
        viewState.filtersViewModel.chosenCuisine = appliedFilters.cuisine
        viewState.filtersViewModel.chosenDiet = appliedFilters.diet
        viewState.filtersViewModel.chosenMeal = appliedFilters.meal
        viewState.filtersViewModel.chosenIntolerances = Set(appliedFilters.intolerances)
        viewState.filtersViewModel.maxCalories = appliedFilters.maxCalories
        
        viewState.filtersViewModel.initialFilters = appliedFilters
        
        viewState.isShowingFilters = true
    }
    
    private func handleSortingTypeSelected(type: SortingOption) {
        if type != selectedSorting {
            selectedSorting = type
            
            runSearch()
        }
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + LocalConstants.delayBeforeHidingSheet
        ) { [weak self] in
            self?.viewState.isShowingSorting = false
        }
    }
    
    private func handleApplyFiltersButtonTapped(_ filters: AppliedFilters) {
        guard appliedFilters != filters else {
            return
        }
        
        appliedFilters = filters
        
        viewState.isShowingFilters = false
        
        runSearch()
    }
    
    // MARK: - Pagination
    
    private func recipeCardAppeared(id: Int) {
        guard recipes.count < totalResults,
              recipesLoadingTask.isNil,
              let index = recipes.firstIndex(where: { $0.id == id }),
              index == recipes.count - 1
        else {
            return
        }
        
        viewState.recipesViewModel.updateIsLoadingNextPage(to: true)
        
        loadRecipes(offset: recipes.count)
    }
    
    // MARK: - Helpers
    
    private func cancelTasks() {
        recipesLoadingTask?.cancel()
        recipesLoadingTask = nil
        
        autocompleteLoadingTask?.cancel()
        autocompleteLoadingTask = nil
    }
}

// MARK: - SearchScreenInput

extension SearchScreenPresenter: SearchScreenInput {
    func bootstrap() {
        setupSearchBox()
        setupSearchSuggestions()
        setupSortingAndFilters()
        
        subscribeToRecipeCardAppeared()
        subscribeToSearchHistoryChanges()
    }
}

// MARK: - SearchScreenViewOutput

extension SearchScreenPresenter: SearchScreenViewOutput {
    func endEditing() {
        searchBoxInput?.endEditing()
    }
    
    func didTapCancel() {
        output?.searchScreenDidRequest(event: .tappedCancelButton)
    }
}

// MARK: - SearchBoxOutput

extension SearchScreenPresenter: SearchBoxOutput {
    func searchBoxDidRequest(event: SearchBoxEvent) {
        switch event {
        case let .textChanged(text):
            if text.isEmpty {
                viewState.suggestionsViewModel.autocompletes.removeAll()
                viewState.updateIsShowingSearchSuggestions(to: true)
            } else {
                loadAutocomplete(query: text)
            }
            
        case .returnKeyTapped:
            searchQuery = searchBoxInput?.getText() ?? ""
            viewState.updateIsShowingSearchSuggestions(to: false)
            
            setSortingAndFiltersToDefault()
            cancelTasks()
            runSearch()
            
        case .textFieldBecameFocused:
            viewState.updateIsShowingSearchSuggestions(to: true)
            
            if let text = searchBoxInput?.getText(), !text.isEmpty {
                viewState.updateIsShowingSearchSuggestions(to: true)
                
                loadAutocomplete(query: text)
            }
        }
    }
}
