//
//  CharactersView+ViewModel.swift
//  HarryPotter
//
//  Created by Mark Brindle on 03/11/2024.
//

import Foundation
import Observation

extension CharactersView {
    @Observable
    final class ViewModel {
        var characterData: [HPCharacter] {
            didSet {
                filterValues(search: "")
            }
        }
        var filteredItems: [HPCharacter] = []
        
        func filterValues(search: String) {
            if search.isEmpty {
                filteredItems = characterData
            } else {
                let list = characterData.filter { item in
                    item.name.localizedStandardContains(search) || item.actor.localizedStandardContains(search)
                }
                filteredItems = list
            }
        }
        
        private var loading: Loading<[HPCharacter]>
        
        @MainActor init(loading: @escaping Loading<[HPCharacter]>) {
            self.characterData = []
            self.loading = loading
        }
        
        @MainActor func load() async throws {
            let characters = try await loading()
            self.characterData = characters
        }
    }
}
