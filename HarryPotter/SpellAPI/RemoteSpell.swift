//
//  RemoteSpell.swift
//  HarryPotter
//
//  Created by Mark Brindle on 03/11/2024.
//

import Foundation

struct RemoteSpell: Decodable {
    let id: UUID
    let name: String
    let description: String
}
