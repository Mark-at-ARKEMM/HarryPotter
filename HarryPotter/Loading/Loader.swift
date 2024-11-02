//
//  Loader.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

typealias Loading<T> = () async throws -> T

protocol Loader<T> {
    associatedtype T
    func load() async throws -> [T]
}

protocol ItemLoader<T> where T: Identifiable {
    associatedtype T
    @MainActor func loadItem(withID id: T.ID) async throws -> T
}
