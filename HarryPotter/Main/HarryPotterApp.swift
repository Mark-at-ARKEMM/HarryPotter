//
//  HarryPotterApp.swift
//  HarryPotter
//
//  Created by Mark Brindle on 02/11/2024.
//

import Foundation
import SwiftUI

//@main
struct HarryPotterApp: App {
    @State private var appData = ApplicationData()
    @State private var charactersViewModel = CharactersView.ViewModel(loading: { try await RemoteCharacterLoader(client: URLSession.shared).load() } )
    @State private var spellsViewModel = SpellsView.ViewModel(loading: { try await RemoteSpellLoader(client: URLSession.shared).load() } )

    var body: some Scene {
        return WindowGroup {
            ContentView(charactersViewModel: charactersViewModel, spellsViewModel: spellsViewModel)
                .environment(appData)
        }
    }
}
