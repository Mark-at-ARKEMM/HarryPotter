//
//  CharactersView.swift
//  HarryPotter
//
//  Created by Mark Brindle on 02/11/2024.
//

import Foundation
import SwiftUI

struct CharactersView: View {
    @Environment(ApplicationData.self) private var appData
    
    @State private var searchTerm: String
    @State private var title: String
    @Bindable var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredItems) { character in
                let vm = CellCharacterView.ViewModel(model: character)
                CellCharacterView(viewModel: vm)
            }
            .navigationTitle(Text(title))
        }
        .searchable(text: $searchTerm, prompt: Text("Search by title & Author"))
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
    
    init(searchTerm: String = "", title: String = "Characters", viewModel: CharactersView.ViewModel) {
        self.searchTerm = searchTerm
        self.viewModel = viewModel
        self.title = title
    }
}

#Preview {
    CharactersView(viewModel: CharactersView.ViewModel(loading: {
        let client = PreviewCharactersClient()
        return try await RemoteCharacterLoader(client: client).load()
    } ))
    .environment(ApplicationData())
}

final class PreviewCharactersClient: HTTPClient {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        dummy()
    }
    
    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        dummy()
    }
    
    private func dummy() -> (Data, HTTPURLResponse) {
        if let filepath = Bundle.main.path(forResource: "characters", ofType: "json") {
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
    
