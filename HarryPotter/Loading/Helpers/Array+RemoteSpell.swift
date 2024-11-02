//
//  Array+RemoteSpell.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

extension Array where Element == RemoteSpell {
    func toModels() -> [Spell] {
        map { Spell(id: $0.id, name: $0.name, description: $0.description) }
    }
}
