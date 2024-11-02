//
//  Array+RemoteCharacter.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

extension Array where Element == RemoteCharacter {
    func toModels() -> [HPCharacter] {
        map { HPCharacter(id: $0.id, name: $0.name, alternateNames: $0.alternate_names, species: $0.species, gender: $0.gender, house: $0.house, dateOfBirth: $0.dateOfBirth, yearOfBirth: $0.yearOfBirth, wizard: $0.wizard, ancestry: $0.ancestry, eyeColour: $0.eyeColour, hairColour: $0.hairColour, wand: Wand(wood: $0.wand.wood, core: $0.wand.core, length: $0.wand.length), patronus: $0.patronus, hogwartsStudent: $0.hogwartsStudent, hogwartsStaff: $0.hogwartsStaff, actor: $0.actor, alternateActors: $0.alternate_actors, alive: $0.alive, image: $0.image) }
    }
}
