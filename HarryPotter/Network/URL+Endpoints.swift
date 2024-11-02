//
//  URL+Endpoints.swift
//  HarryPotter
//
//  Created by Mark Brindle on 07/11/2024.
//

import Foundation


extension URL {
    static var forLoadingCharacters: URL {
        URL(string: Endpoint.characters)!
    }
    
    static func forLoadingCharacter(withID id: String) -> URL {
        URL(string: Endpoint.character)!.appendingPathComponent(id)
    }
    
    static var forLoadingSpells: URL {
        URL(string: Endpoint.spells)!
    }
}
