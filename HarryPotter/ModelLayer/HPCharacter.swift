//
//  HPCharacter.swift
//  HarryPotter
//
//  Created by Mark Brindle on 03/11/2024.
//

import Foundation

struct HPCharacter: Identifiable, Equatable {
    let id: UUID
    let name: String
    let alternateNames: [String]
    let species: String
    let gender: String
    let house: String
    let dateOfBirth: String?
    let yearOfBirth: Int?
    let wizard: Bool
    let ancestry: String
    let eyeColour: String
    let hairColour: String
    let wand: Wand
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    let alternateActors: [String]
    let alive: Bool
    let image: String
}
