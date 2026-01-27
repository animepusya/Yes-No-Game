//
//  RemoteContentClient.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 27.01.2026.
//

import Foundation

final class RemoteContentClient {
    private let manifestURL: URL

    init(manifestURL: URL) {
        self.manifestURL = manifestURL
    }

    func fetchManifest() async throws -> ContentManifest {
        let (data, _) = try await URLSession.shared.data(from: manifestURL)
        return try JSONDecoder().decode(ContentManifest.self, from: data)
    }

    func fetchCardsData(path: String) async throws -> Data {
        let url = manifestURL.deletingLastPathComponent().appendingPathComponent(path)
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
