//
//  ContentViewViewModelTests.swift
//  HarryPotterTests
//
//  Created by Mark Brindle on 05/11/2024.
//

import Foundation
import Testing
@testable import HarryPotter

struct ViewModelTests {
    struct CharactersView_ViewModel_Tests {
        @MainActor @Test func init_hasNoCharacterData() {
            let client = NetworkingMock(result: .success(NetworkingMock.networkResponseAllCharacters))
            let sut = CharactersView.ViewModel(loading: {
                try await RemoteCharacterLoader(client: client).load()
            })
            
            #expect(sut.characterData.isEmpty)
        }
        
        @MainActor @Test func load_deliversCharacters() async throws {
            let client = NetworkingMock(result: .success(NetworkingMock.networkResponseHermione))
            let loader = RemoteCharacterLoader(client: client)
            let sut = CharactersView.ViewModel(loading: {
                try await loader.load()
            })
            
            try await sut.load()
            
            #expect(sut.characterData.count == 1)
            #expect(sut.characterData.first?.name == "Hermione Granger")
        }
        
        @MainActor @Test func load_filtersCharacterDataWithEmptySearch() async throws {
            let client = NetworkingMock(result: .success(NetworkingMock.networkResponseHermione))
            let loader = RemoteCharacterLoader(client: client)
            let sut = CharactersView.ViewModel(loading: {
                try await loader.load()
            })
            
            try await sut.load()
            
            #expect(sut.filteredItems.count == 1)
            #expect(sut.characterData == sut.filteredItems)
        }
        
        @MainActor @Test func filterValues_deliversfilteredItems() async throws {
            let severus = uniqueCharacter(name: "Severus Snape", actor: "Alan Rickman")
            let harry = uniqueCharacter(name: "Harry Potter", actor: "Daniel Radcliffe")
            let albus = uniqueCharacter(name: "Albus Dumbledore", actor: "Richard Harris")
            let hermione = uniqueCharacter(name: "Hermione Granger", actor: "Emma Watson")
            let ron = uniqueCharacter(name: "Ron Weasley", actor: "Rupert Grint")
            let dolores = uniqueCharacter(name: "Dolores Umbridge", actor: "Imelda Staunton")
            let characters = [severus, harry, albus, hermione, ron, dolores]
            let sut = CharactersView.ViewModel(loading: { characters })
            
            try await sut.load()
            
            #expect(sut.characterData.count == 6)

            sut.filterValues(search: "g")
            
            #expect(sut.filteredItems.count == 3)
            #expect(sut.filteredItems.contains(severus) == false)
            #expect(sut.filteredItems.contains(harry) == false)
            #expect(sut.filteredItems.contains(albus) == false)
            #expect(sut.filteredItems.contains(hermione) == true)
            #expect(sut.filteredItems.contains(ron) == true)
            #expect(sut.filteredItems.contains(dolores) == true)

            sut.filterValues(search: "p")
            
            #expect(sut.filteredItems.count == 3)
            #expect(sut.filteredItems.contains(severus) == true)
            #expect(sut.filteredItems.contains(harry) == true)
            #expect(sut.filteredItems.contains(albus) == false)
            #expect(sut.filteredItems.contains(hermione) == false)
            #expect(sut.filteredItems.contains(ron) == true)
            #expect(sut.filteredItems.contains(dolores) == false)

            sut.filterValues(search: "k")
            
            #expect(sut.filteredItems.count == 1)
            #expect(sut.filteredItems.contains(severus) == true)
            #expect(sut.filteredItems.contains(harry) == false)
            #expect(sut.filteredItems.contains(albus) == false)
            #expect(sut.filteredItems.contains(hermione) == false)
            #expect(sut.filteredItems.contains(ron) == false)
            #expect(sut.filteredItems.contains(dolores) == false)
        }
        
        @MainActor @Test func load_throwsError_onFailure() async throws {
            var expectedError: Error? = nil
            let client = NetworkingMock(result: .failure(anyError()))
            let loader = RemoteCharacterLoader(client: client)
            let sut = CharactersView.ViewModel(loading: {
                try await loader.load()
            })
            
            do {
                try await sut.load()
            } catch {
                expectedError = error
            }
            
            #expect(expectedError != nil)
        }
    }
    
    struct CellCharacterView_ViewModel_Tests {
        @Test func init_deliversAllRequiredCharacterValues() {
            let model = uniqueCharacter(name: "any Name", actor: "any actor", image: "https://any-image-url.com")
            let url = URL(string: model.image)

            let sut = CellCharacterView.ViewModel(model: model)
            
            #expect(sut.title == model.name)
            #expect(sut.detailText == model.actor)
            #expect(sut.url == url)
        }
        
        @Test func yearOfBirth_withNoValue_deliversAnEmptyString() {
            let model = uniqueCharacter(yearOfBirth: nil)

            let sut = CellCharacterView.ViewModel(model: model)
            
            #expect(sut.yearOfBirth == "")
        }

        @Test func yearOfBirth_withValidValue_deliversCorrectString() {
            let model = uniqueCharacter(yearOfBirth: 1970)

            let sut = CellCharacterView.ViewModel(model: model)
            
            #expect(sut.yearOfBirth == "1970")
        }
    }
    
    struct SpellsView_ViewModel_Tests {
        @MainActor
        @Test func init_hasNoSpellData() {
            let client = NetworkingMock(result: .success(NetworkingMock.networkResponseAllCharacters))
            let sut = SpellsView.ViewModel(loading: {
                try await RemoteSpellLoader(client: client).load()
            })
            
            #expect(sut.items.isEmpty)
        }
        
        @MainActor @Test func load_deliversSpells() async throws {
            let client = NetworkingMock(result: .success(NetworkingMock.networkResponseHermione))
            let loader = RemoteCharacterLoader(client: client)
            let sut = CharactersView.ViewModel(loading: {
                try await loader.load()
            })
            
            try await sut.load()
            
            #expect(sut.characterData.count == 1)
            #expect(sut.characterData.first?.name == "Hermione Granger")
        }
        
        @MainActor @Test func load_filtersItemsWithEmptySearch() async throws {
            let client = NetworkingMock(result: .success(NetworkingMock.networkResponseAllSpells))
            let loader = RemoteSpellLoader(client: client)
            let sut = SpellsView.ViewModel(loading: {
                try await loader.load()
            })
            
            try await sut.load()
            
            #expect(sut.filteredItems.count == 77)
            #expect(sut.items == sut.filteredItems)
        }
        
        @MainActor @Test func filterValues_deliversfilteredItems() async throws {
            let aguamenti = Spell(id: UUID(), name: "Aguamenti", description: "Summons water")
            let avadaKedavra = Spell(id: UUID(), name: "Avada Kedavra", description: "Also known as The Killing Curse, the most evil spell in the Wizarding World; one of three Unforgivable Curses; Harry Potter is the only known witch or wizard to survive it")
            let brackiumEmendo = Spell(id: UUID(), name: "Brackium Emendo", description: "Heals broken bones")
            let crucio = Spell(id: UUID(), name: "Crucio", description: "One of three Unforgivable Curses, it causes unbearable pain in the target")
            let imperio = Spell(id: UUID(), name: "Imperio", description: "One of the three Unforgivable Curses, it places the target under the complete control of the caster")
            let geminio = Spell(id: UUID(), name: "Geminio", description: "Duplicates objects")
            let homonculusCharm = Spell(id: UUID(), name: "Homonculus Charm", description: "Detects anyone's true identity and location on a piece of parchment; used to create the Marauder's Map")
            let piertotumLocomotor = Spell(id: UUID(), name: "Piertotum Locomotor", description: "Incantation used to bring to life inanimate objects and artifacts")
            let protego = Spell(id: UUID(), name: "Protego", description: "Casts an invisible shield around the caster, protecting against spells and objects (except for The Killing Curse)")
            let spells = [aguamenti, avadaKedavra, brackiumEmendo, crucio, imperio, geminio, homonculusCharm, piertotumLocomotor, protego]
            let sut = SpellsView.ViewModel(loading: { spells })
            
            try await sut.load()
            
            #expect(sut.items.count == 9)

            sut.filterValues(search: "three unforgivable curses")
            
            #expect(sut.filteredItems.count == 3)
            #expect(sut.filteredItems.contains(aguamenti) == false)
            #expect(sut.filteredItems.contains(avadaKedavra) == true)
            #expect(sut.filteredItems.contains(brackiumEmendo) == false)
            #expect(sut.filteredItems.contains(crucio) == true)
            #expect(sut.filteredItems.contains(imperio) == true)
            #expect(sut.filteredItems.contains(geminio) == false)
            #expect(sut.filteredItems.contains(homonculusCharm) == false)
            #expect(sut.filteredItems.contains(piertotumLocomotor) == false)
            #expect(sut.filteredItems.contains(protego) == false)

            sut.filterValues(search: "p")
            
            #expect(sut.filteredItems.count == 7)
            #expect(sut.filteredItems.contains(aguamenti) == false)
            #expect(sut.filteredItems.contains(avadaKedavra) == true)
            #expect(sut.filteredItems.contains(brackiumEmendo) == false)
            #expect(sut.filteredItems.contains(crucio) == true)
            #expect(sut.filteredItems.contains(imperio) == true)
            #expect(sut.filteredItems.contains(geminio) == true)
            #expect(sut.filteredItems.contains(homonculusCharm) == true)
            #expect(sut.filteredItems.contains(piertotumLocomotor) == true)
            #expect(sut.filteredItems.contains(protego) == true)

            sut.filterValues(search: "ncu")
            
            #expect(sut.filteredItems.count == 1)
            #expect(sut.filteredItems.contains(aguamenti) == false)
            #expect(sut.filteredItems.contains(avadaKedavra) == false)
            #expect(sut.filteredItems.contains(brackiumEmendo) == false)
            #expect(sut.filteredItems.contains(crucio) == false)
            #expect(sut.filteredItems.contains(imperio) == false)
            #expect(sut.filteredItems.contains(geminio) == false)
            #expect(sut.filteredItems.contains(homonculusCharm) == true)
            #expect(sut.filteredItems.contains(piertotumLocomotor) == false)
            #expect(sut.filteredItems.contains(protego) == false)

            sut.filterValues(search: "")
            
            #expect(sut.filteredItems.count == 9)
            #expect(sut.filteredItems.contains(aguamenti) == true)
            #expect(sut.filteredItems.contains(avadaKedavra) == true)
            #expect(sut.filteredItems.contains(brackiumEmendo) == true)
            #expect(sut.filteredItems.contains(crucio) == true)
            #expect(sut.filteredItems.contains(imperio) == true)
            #expect(sut.filteredItems.contains(geminio) == true)
            #expect(sut.filteredItems.contains(homonculusCharm) == true)
            #expect(sut.filteredItems.contains(piertotumLocomotor) == true)
            #expect(sut.filteredItems.contains(protego) == true)
        }
        
        @MainActor @Test func load_throwsError_onFailure() async throws {
            var expectedError: Error? = nil
            let client = NetworkingMock(result: .failure(anyError()))
            let loader = RemoteSpellLoader(client: client)
            let sut = SpellsView.ViewModel(loading: {
                try await loader.load()
            })
            
            do {
                try await sut.load()
            } catch {
                expectedError = error
            }
            
            #expect(expectedError != nil)
        }

    }

    struct CellSpellsView_ViewModel_Tests {
        @Test func init_deliversSpellValues() {
            let model = Spell(id: UUID(), name: "any name", description: "any description")

            let sut = CellSpellView.ViewModel(model: model)
            
            #expect(sut.title == model.name)
            #expect(sut.detailText == model.description)
        }

        @Test func load_deliversSpellValues() {
            let model = Spell(id: UUID(), name: "any name", description: "any description")

            let sut = CellSpellView.ViewModel(model: model)
            
            #expect(sut.title == model.name)
            #expect(sut.detailText == model.description)
        }
    }
}

// MARK: - Helpers

func anyError() -> Error {
    NSError(domain: "an error", code: 0)
}

public func uniqueCharacter(
    id: UUID = UUID(),
    name: String = "",
    alternateNames: [String] = [],
    species: String = "",
    gender: String = "",
    house: String = "",
    dateOfBirth: String? = nil,
    yearOfBirth: Int? = nil,
    wizard: Bool = false,
    ancestry: String = "",
    eyeColour: String = "",
    hairColour: String = "",
    wand: Wand = Wand(wood: "", core: "", length: nil),
    patronus: String = "",
    hogwartsStudent: Bool = false,
    hogwartsStaff: Bool = false,
    actor: String = "",
    alternateActors: [String] = [],
    alive: Bool = true,
    image: String = ""
) -> HPCharacter {
    HPCharacter(id: id, name: name, alternateNames: alternateNames, species: species, gender: gender, house: house, dateOfBirth: dateOfBirth, yearOfBirth: yearOfBirth, wizard: wizard, ancestry: ancestry, eyeColour: eyeColour, hairColour: hairColour, wand: wand, patronus: patronus, hogwartsStudent: hogwartsStudent, hogwartsStaff: hogwartsStaff, actor: actor, alternateActors: alternateActors, alive: alive, image: image)
}
