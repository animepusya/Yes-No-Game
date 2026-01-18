//
//  RemoteImageLoader.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 18.01.2026.
//

import UIKit

@MainActor
final class RemoteImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    func load(from urlString: String) async {
        guard !isLoading else { return }
        guard let url = URL(string: urlString) else { return }

        // Диск-кеш
        if let cached = ImageDiskCache.shared.load(for: url),
           let img = UIImage(data: cached) {
            self.image = img
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let img = UIImage(data: data) else { return }
            ImageDiskCache.shared.save(data, for: url)
            self.image = img
        } catch {
            // можно оставить пустым
        }
    }
}
