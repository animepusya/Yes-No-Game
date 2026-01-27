//
//  ViewModel.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cards: [Card]
    @Published var currentCard: Card?
    @Published var showHint = false
    @Published var showAnswer = false
    let isRandomMode: Bool
    
    init(cards: [Card], isRandomMode: Bool = false) {
        self.cards = cards
        self.currentCard = cards.randomElement()
        self.isRandomMode = isRandomMode
    }
    
    init(singleCard: Card, allCards: [Card], isRandomMode: Bool = false) {
        self.cards = allCards
        self.currentCard = singleCard
        self.isRandomMode = isRandomMode
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
