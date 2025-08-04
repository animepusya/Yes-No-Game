//
//  MainViewModel.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 30.07.2025.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var categoriesWithCards: [Category] = []
    @Published var selectedCard: Card?
    @Published var isRandomMode: Bool = false

    init() {
        loadCategoriesWithCards()
    }

    func loadCategoriesWithCards() {
        let allCards = CardLoader.load()
        let categoriesWithContent = Category.allCases.filter { category in
            allCards.contains(where: { $0.category == category.rawValue })
        }
        self.categoriesWithCards = categoriesWithContent
    }

    func selectRandomCard() {
        let allCards = CardLoader.load()
        let filteredCards = allCards.filter { card in
            categoriesWithCards.contains(where: { $0.rawValue == card.category })
        }

        if let random = filteredCards.randomElement() {
            selectedCard = random
            isRandomMode = true
        }
    }

    func selectSpecificCard(_ card: Card) {
        selectedCard = card
        isRandomMode = false
    }
}
