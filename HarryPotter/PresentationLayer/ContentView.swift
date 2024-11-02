//
//  ContentView.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(ApplicationData.self) private var appData
    
    @Bindable var charactersViewModel: CharactersView.ViewModel
    @Bindable var spellsViewModel: SpellsView.ViewModel

    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                CharactersView(viewModel: charactersViewModel)
                    .tabItem {
                        Label("Characters", systemImage: "person.3.fill")
                    }
                
                SpellsView(viewModel: spellsViewModel)
                    .tabItem {
                        Label("Spells", systemImage: "wand.and.stars.inverse")
                    }
            }
            appData.errorView()
        }
    }
}

#Preview {
    ContentView(charactersViewModel: CharactersView.ViewModel(loading: {
        let client = PreviewCharactersClient()
        return try await RemoteCharacterLoader(client: client).load()
    } ), spellsViewModel: SpellsView.ViewModel(loading: {
        let client = PreviewSpellsClient()
        return try await RemoteSpellLoader(client: client).load()
    }))
    .environment(ApplicationData())
}
