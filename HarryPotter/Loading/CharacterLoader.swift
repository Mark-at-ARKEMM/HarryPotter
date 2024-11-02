//
//  CharacterLoader.swift
//  HarryPotter
//
//  Created by Mark Brindle on 07/11/2024.
//

protocol CharacterLoader: Loader, ItemLoader {
    func load() async throws -> [HPCharacter]
    func loadItem(withID id: HPCharacter.ID) async throws -> HPCharacter
}
