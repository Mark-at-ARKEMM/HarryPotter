//
//  RemoteSpellLoader.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import Foundation

final class RemoteSpellLoader {
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    @MainActor
    init(client: HTTPClient) {
        self.client = client
    }

    @MainActor
    func load() async throws -> [Spell] {
        let url =  URL.forLoadingSpells
        let (data, response) = try await client.get(from: url)
        let remoteItems = try SpellsMapper.map(data, from: response)
        return remoteItems.toModels()
    }
}

extension RemoteSpellLoader: Loader {}
