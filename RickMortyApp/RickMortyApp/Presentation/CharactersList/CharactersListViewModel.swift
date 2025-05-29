//
//  CharactersListViewModel.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

class CharactersListViewModel: ObservableObject {
    // MARK: - Published vars

    @Published var state = ViewState.loaded
    @Published var charactersListToShow = [CharacterUIModel]()

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
        switch action {
        case .fetchCharacters:
            await fetchCharactersList()
        }
    }

    // MARK: - Private functions

    private func fetchCharactersList() async {
        await setLoadingState(state: .loading)

        let result = await fetchCharactersUseCase.execute()

        guard case .success(let charactersList) = result else {
            await handleError(error: result.failureValue as? CharactersDomainError)
            return
        }
        
        await setLoadingState(state: .loaded)

        await setCharactersListToShow(charactersList.map { CharacterUIModel(domainModel: $0) })
    }

    private func handleError(error: CharactersDomainError?) async {
        await setLoadingState(state: .error)
        // Poner en la ultima celda de el error seguido de un boton de reintentar.
        // showErrorMessage = charactersErrorUIMapper.map(error: error)
        // In main actor.
    }

    // MARK: - MainActor methods

    @MainActor
    private func setCharactersListToShow(_ charactersList: [CharacterUIModel]) {
        charactersListToShow = charactersList
    }

    @MainActor
    private func setLoadingState(state: ViewState) {
        self.state = state
    }
}
