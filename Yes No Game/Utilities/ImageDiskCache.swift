//
//  ImageDiskCache.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 18.01.2026.
//

import Foundation

final class ImageDiskCache {
    static let shared = ImageDiskCache()
    private init() {}

    private var imagesDir: URL {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let url = dir.appendingPathComponent("remote_images", isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        return url
    }

    private func fileURL(for url: URL) -> URL {
        // безопасное имя файла из url
        let name = String(url.absoluteString.hashValue)
        return imagesDir.appendingPathComponent(name)
    }

    func load(for url: URL) -> Data? {
        let f = fileURL(for: url)
        return try? Data(contentsOf: f)
    }

    func save(_ data: Data, for url: URL) {
        let f = fileURL(for: url)
        try? data.write(to: f, options: [.atomic])
    }
}
