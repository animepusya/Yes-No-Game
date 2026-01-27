//
//  CardsDiskCache.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 27.01.2026.
//

import Foundation

final class CardsDiskCache {
    private let baseName: String

    init(baseName: String = "cards") {
        self.baseName = baseName
    }

    func read(lang: String) -> Data? {
        try? Data(contentsOf: url(lang: lang))
    }

    func write(_ data: Data, lang: String) throws {
        try data.write(to: url(lang: lang), options: [.atomic])
    }

    private func url(lang: String) -> URL {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("\(baseName)_\(lang).json")
    }
}
