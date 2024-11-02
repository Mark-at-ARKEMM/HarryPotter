//
//  NetworkingMock.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import Foundation
import HarryPotter

class NetworkingMock: HTTPClient {
    // Characters
    static let networkResponseHarry = LoadData.fromJSON("harry")
    static let networkResponseHermione = LoadData.fromJSON("hermione")
    static let networkResponseBoth = LoadData.fromJSON("both")
    static let networkResponseAllCharacters = LoadData.fromJSON("characters")


    // Spells
    static let networkResponseGlisseo = LoadData.fromJSON("glisseo")
    static let networkResponseImobilus = LoadData.fromJSON("immobulus")
    static let networkResponseProtego = LoadData.fromJSON("protego")
    static let networkResponseTarantellagra = LoadData.fromJSON("tarantellagra")
    static let networkResponseAllSpells = LoadData.fromJSON("spells")

    var result: Result<Data, Error>
    
    init(result: Result<Data, Error>) {
        self.result = result
    }

    func data(
        from url: URL,
        delegate: URLSessionTaskDelegate?
    ) async throws -> (Data, URLResponse) {
        try (result.get(), HTTPURLResponse())
    }
    
    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "NetworkingMockHTTPClient", code: 0)
        }
        
        return (data, httpResponse)
    }
    

}

