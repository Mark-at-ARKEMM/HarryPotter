//
//  URLSession+HTTPClient.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import Foundation

extension URLSession: HTTPClient {
    public func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        let request = URLRequest(url: url)
        let (data, response) = try await data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(URLError.badServerResponse)
        }
        
        return (data, httpResponse)
    }
}
