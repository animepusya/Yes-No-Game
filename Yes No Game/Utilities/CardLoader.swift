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
        
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "json") else {
            print("❌ Не найден путь к cards.json")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let cards = try JSONDecoder().decode([Card].self, from: data)
            print("✅ Успешно загружено карточек: \(cards.count)")
            return cards
        } catch {
            print("❌ Ошибка при загрузке или декодировании: \(error)")
            return []
        }
    }
}

