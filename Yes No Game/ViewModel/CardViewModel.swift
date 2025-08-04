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
    let isRandomMode: Bool
    
    init(category: Category?) {
        self.isRandomMode = false
        loadCards(for: category)
    }
    
    init(singleCard: Card, isRandomMode: Bool = false) {
        self.cards = CardLoader.load()
        self.currentCard = singleCard
        self.isRandomMode = isRandomMode
    }
    
    func loadCards(for category: Category?) {
        cards = CardLoader.load().filter {
            guard let category = category else { return true }
            return $0.category == category.rawValue
        }
        currentCard = cards.randomElement()
    }
    
    func nextCard() {
        guard !cards.isEmpty else { return }
        
        var next: Card?
        repeat {
            next = cards.randomElement()
        } while next?.id == currentCard?.id && cards.count > 1

        currentCard = next
        showHint = false
        showAnswer = false
    }
}
