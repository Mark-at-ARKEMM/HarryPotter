//
//  SpellsView.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import SwiftUI

struct SpellsView: View {
    @Environment(ApplicationData.self) private var appData

    @State private var searchTerm: String
    @State private var title: String
    @Bindable var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredItems) { spell in
                let vm = CellSpellView.ViewModel(model: spell)
                CellSpellView(viewModel: vm)
            }.navigationTitle(Text(title))
        }
        .searchable(text: $searchTerm, prompt: Text("Search by name & description"))
        .onChange(of: searchTerm, initial: false) { oldValue, newValue in
            let search = newValue.trimmingCharacters(in: .whitespaces)
            viewModel.filterValues(search: search)
        }
        .task {
            do {
                try await viewModel.load()
            } catch {
                appData.errorMessage = ErrorMessage(.error, message: error.localizedDescription)
            }
        }
    }
    
    init(searchTerm: String = "", title: String = "Spells", viewModel: SpellsView.ViewModel) {
        self.searchTerm = searchTerm
        self.title = title
        self.viewModel = viewModel
    }
}

#Preview {
    SpellsView(viewModel: SpellsView.ViewModel(loading: {
        let client = PreviewSpellsClient()
        return try await RemoteSpellLoader(client: client).load()
    } ))
    .environment(ApplicationData())
}

final class PreviewSpellsClient: HTTPClient {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        dummy()
    }
    
    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        dummy()
    }
    
    private func dummy() -> (Data, HTTPURLResponse) {
        if let filepath = Bundle.main.path(forResource: "spells", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return (contents.data(using: .utf8)!, HTTPURLResponse())
            } catch {
                // Fall through to sending empty data
            }
        }
        return (Data(), HTTPURLResponse())
    }
}


