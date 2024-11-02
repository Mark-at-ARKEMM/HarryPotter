//
//  HTTPClient.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import Foundation

public protocol HTTPClient {
    @MainActor func get(from url: URL) async throws -> (Data, HTTPURLResponse)
    @MainActor func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}


extension HTTPClient {
    // If we want to avoid having to always pass 'delegate: nil'
    // at call sites where we're not interested in using a delegate,
    // we also have to add the following convenience API (which
    // URLSession itself provides when using it directly):
    @MainActor public func data(from url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url, delegate: nil)
    }
}

