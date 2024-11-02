//
//  SpellsMapper.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import Foundation

struct SpellsMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteSpell] {
        guard response.isOK, let items: [RemoteSpell] = try data.decodeFromJSON() else {
            throw RemoteSpellLoader.Error.invalidData
        }
 
        return items
    }
}
