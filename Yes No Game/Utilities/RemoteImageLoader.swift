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

    func loadFromCacheOrNetwork(_ urlString: String) {
        guard let url = URL(string: urlString),
              url.scheme?.hasPrefix("http") == true else {
            print("❌ Некорректный imageUrl: \(urlString)")
            return
        }

        // 1) Диск-кеш (оффлайн-first)
        if let cached = ImageDiskCache.shared.load(for: url),
           let img = UIImage(data: cached) {
            self.image = img
            return
        }

        // 2) Сеть (если кеш пуст)
        Task {
            await loadFromNetwork(url)
        }
    }

    private func loadFromNetwork(_ url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let img = UIImage(data: data) else { return }
            ImageDiskCache.shared.save(data, for: url)
            self.image = img
        } catch {
            let nsError = error as NSError
            if nsError.code != NSURLErrorNotConnectedToInternet {
                print("🌐 Remote image load error: \(error)")
            }
        }
    }
}
