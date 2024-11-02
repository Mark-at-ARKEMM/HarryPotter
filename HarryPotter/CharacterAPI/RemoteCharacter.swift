//
//  RemoteCharacter.swift
//  HarryPotter
//
//  Created by Mark Brindle on 03/11/2024.
//

import Foundation

struct RemoteCharacter: Decodable {
    let id: UUID
    let name: String
    let alternate_names: [String]
    let species: String
    let gender: String
    let house: String
    let dateOfBirth: String?
    let yearOfBirth: Int?
    let wizard: Bool
    let ancestry: String
    let eyeColour: String
    let hairColour: String
    let wand: RemoteWand
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    let alternate_actors: [String]
    let alive: Bool
    let image: String
}
