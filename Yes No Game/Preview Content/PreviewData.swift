//
//  PreviewData.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import Foundation

let previewCard = Card(
    category: "Military",
    title: "Салют",
    description: "Солдаты стояли на крыше и стреляли в небо. Это спасло город.",
    hint: "Они стреляли не по врагу.",
    explanation: "Солдаты запускали сигнальные ракеты, чтобы показать сбитому пилоту, где находится база. Пилот вернулся, сообщил координаты врага — и это спасло город.",
    imageName: "militarySalute"
)

class MockCardViewModel: CardViewModel {
    init() {
        super.init(category: nil)
        self.cards = [previewCard]
        self.currentCard = previewCard
    }
}
