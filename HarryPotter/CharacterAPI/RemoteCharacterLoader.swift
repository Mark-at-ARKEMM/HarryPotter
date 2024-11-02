//
//  RemoteCharacterLoader.swift
//  HarryPotter
//
//  Created by Mark Brindle on 07/11/2024.
//

import Foundation

final class RemoteCharacterLoader {
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
    func load() async throws -> [HPCharacter] {
        let url =  URL.forLoadingCharacters
        let (data, response) = try await client.get(from: url)
        let remoteItems = try CharactersMapper.map(data, from: response)
        return remoteItems.toModels()
    }

    @MainActor
    func loadItem(withID id: HPCharacter.ID) async throws -> HPCharacter {
        let url =  URL.forLoadingCharacter(withID: id.uuidString)
        let (data, response) = try await client.get(from: url)
        let remoteItems = try CharactersMapper.map(data, from: response)
        return remoteItems.toModels().first!
    }
}

extension RemoteCharacterLoader: CharacterLoader {}
