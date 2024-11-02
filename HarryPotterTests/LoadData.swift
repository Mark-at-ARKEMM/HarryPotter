//
//  LoadData.swift
//  HarryPotterTests
//
//  Created by Mark Brindle on 09/11/2024.
//

import Foundation

class LoadData {
    static func fromJSON(_ filename: String) -> Data {
        if let filepath = Bundle(for: LoadData.self).path(forResource: filename, ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents.data(using: .utf8)!
            } catch {
                // Fall through to sending empty data
            }
        }
        return Data()
    }

}
