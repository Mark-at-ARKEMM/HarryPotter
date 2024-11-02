//
//  CharactersMapper.swift
//  HarryPotter
//
//  Created by Mark Brindle on 07/11/2024.
//

import Foundation

struct CharactersMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteCharacter] {
        guard response.isOK, let items: [RemoteCharacter] = try data.decodeFromJSON() else {
            throw RemoteCharacterLoader.Error.invalidData
        }
 
        return items
    }
}
