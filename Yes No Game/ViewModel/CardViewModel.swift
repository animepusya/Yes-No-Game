//
//  ViewModel.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var currentCard: Card?
    @Published var showHint = false
    @Published var showAnswer = false

    init(category: Category?) {
        loadCards(for: category)
    }
    
    init(singleCard: Card) {
        self.cards = [singleCard]
        self.currentCard = singleCard
    }
    

    func loadCards(for category: Category?) {
        cards = CardLoader.load().filter {
            guard let category = category else { return true }
            return $0.category == category.rawValue
        }
        currentCard = cards.randomElement()
    }

    func nextCard() {
        currentCard = cards.randomElement()
        showHint = false
        showAnswer = false
    }
}
