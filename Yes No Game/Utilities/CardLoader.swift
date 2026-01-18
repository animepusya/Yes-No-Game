//
//  CardLoader.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import Foundation

struct CardLoader {
    
    private static var loadCallCount = 0
    
    static func load() -> [Card] {
        
        loadCallCount += 1
        print("🧾 CardLoader.load() вызван \(loadCallCount) раз")

        guard let data = RemoteContentService.shared.loadCardsDataFallbackToBundle() else {
            print("❌ Не удалось получить данные cards.json ни из кэша, ни из Bundle")
            return []
        }
        
        do {
            let cards = try JSONDecoder().decode([Card].self, from: data)
            print("✅ Успешно загружено карточек: \(cards.count)")
            return cards
        } catch {
            print("❌ Ошибка при декодировании: \(error)")
            return []
        }
    }
}
