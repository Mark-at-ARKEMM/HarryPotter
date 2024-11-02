//
//  Data+decodeFromJSON.swift
//  HarryPotter
//
//  Created by Mark Brindle on 07/11/2024.
//

import Foundation

extension Data {
    func decodeFromJSON<D: Decodable>() throws -> D {
        try JSONDecoder().decode(D.self, from: self)
    }
}
