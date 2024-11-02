//
//  SpellsView+ViewModel.swift
//  HarryPotter
//
//  Created by Mark Brindle on 09/11/2024.
//

import Observation

extension SpellsView {
    @Observable
    final class ViewModel {
        var items: [Spell] {
            didSet {
                filterValues(search: "")
            }
        }
        var filteredItems: [Spell] = []
        
        func filterValues(search: String) {
            if search.isEmpty {
                filteredItems = items
            } else {
                let list = items.filter { item in
                    item.name.localizedStandardContains(search) || item.description.localizedStandardContains(search)
                }
                filteredItems = list
            }
        }
        
        private var loading: Loading<[Spell]>
        
        @MainActor init(loading: @escaping Loading<[Spell]>) {
            self.items = []
            self.loading = loading
        }
        
        @MainActor func load() async throws {
            let items = try await loading()
            self.items = items
        }
    }
}
