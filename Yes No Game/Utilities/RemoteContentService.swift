//
//  RemoteContentService.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 18.01.2026.
//

import Foundation

final class RemoteContentService {
    static let shared = RemoteContentService()
    private init() {}

    private let manifestURL = URL(string: "https://animepusya.github.io/YNG-content/manifest.json")!

    private let versionKey = "remote_cards_content_version"

    private var cachedCardsURL: URL {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("cards.json")
    }

    func loadCardsDataFallbackToBundle() -> Data? {
        if let data = try? Data(contentsOf: cachedCardsURL) {
            return data
        }
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }

    func refreshIfNeeded() async throws -> Bool {
        let (manifestData, _) = try await URLSession.shared.data(from: manifestURL)
        let manifest = try JSONDecoder().decode(ContentManifest.self, from: manifestData)

        let currentVersion = UserDefaults.standard.integer(forKey: versionKey)
        guard manifest.contentVersion > currentVersion else { return false }

        let cardsURL = manifestURL.deletingLastPathComponent().appendingPathComponent(manifest.cardsPath)
        let (cardsData, _) = try await URLSession.shared.data(from: cardsURL)

        _ = try JSONDecoder().decode([Card].self, from: cardsData)

        try cardsData.write(to: cachedCardsURL, options: [.atomic])
        UserDefaults.standard.set(manifest.contentVersion, forKey: versionKey)
        return true
    }
    
    func prefetchImages(from cards: [Card]) {
        let strings = cards.compactMap { $0.imageUrl }.filter { $0.hasPrefix("http") }

        Task.detached(priority: .background) {
            for s in strings {
                guard let url = URL(string: s) else { continue }

                if let cached = ImageDiskCache.shared.load(for: url), !cached.isEmpty {
                    continue
                }

                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    ImageDiskCache.shared.save(data, for: url)
                } catch {
                }
            }
        }
    }
}
