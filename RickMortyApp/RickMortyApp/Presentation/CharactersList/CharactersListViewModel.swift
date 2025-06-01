//
//  CharactersListViewModel.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class CharactersListViewModel: ObservableObject {
    // MARK: - Published vars

    @Published var charactersListToShow = [CharacterEntity]()
    @Published var errorMessage: String?
    @Published var isLastPage: Bool = false
    @Published var state = ViewState.loaded

    private var nextPage: String?
    private var prevPage: String?

    // MARK: - Public Enums

    enum TriggerAction {
        case fetchCharacters
    }

    enum ViewState {
        case error
        case loaded
        case loading
    }

    // MARK: - UseCases

    private let fetchCharactersUseCase: FetchCharactersUseCaseType

    // MARK: - Mappers

    private let charactersErrorUIMapper: CharactersErrorUIMapper

    // MARK: - Init

    init(
        charactersErrorUIMapper: CharactersErrorUIMapper,
        fetchCharactersUseCase: FetchCharactersUseCaseType
    ) {
        self.charactersErrorUIMapper = charactersErrorUIMapper
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }

    // MARK: - Public Functions

    func trigger(_ action: TriggerAction) async {
        await resetError()

        switch action {
        case .fetchCharacters:
            await fetchCharactersList()
        }
    }

    // MARK: - Private functions

    private func fetchCharactersList() async {
        await setViewState(state: .loading)

        let result = await fetchCharactersUseCase.execute(nextPage: nextPage)

        guard case .success(let page) = result else {
            await handleError(error: result.failureValue as? CharactersDomainError)
            return
        }

        self.nextPage = page.next
        self.prevPage = page.prev

        if nextPage == nil && prevPage != nil {
            await setIsLastPage()
        }
        
        await setViewState(state: .loaded)

        await setCharactersListToShow(page.characters.map { $0 })
    }

    // MARK: - MainActor methods

    @MainActor
    private func setIsLastPage() {
        self.isLastPage = true
    }

    @MainActor
    private func handleError(error: CharactersDomainError?) {
        self.errorMessage = charactersErrorUIMapper.map(error: error)
    }

    @MainActor
    private func resetError() {
        self.errorMessage = nil
    }

    @MainActor
    private func setCharactersListToShow(_ charactersList: [CharacterEntity]) {
        self.charactersListToShow.append(contentsOf: charactersList)
    }

    @MainActor
    private func setViewState(state: ViewState) {
        self.state = state
    }
}
