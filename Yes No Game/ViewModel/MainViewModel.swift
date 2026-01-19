//
//  MainViewModel.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 30.07.2025.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var categoriesWithCards: [Category] = []
    @Published var selectedCard: Card?
    @Published var isRandomMode: Bool = false

    @Published private(set) var allCards: [Card] = []

    private var didRunRefresh = false

    init() {
        loadAllCards()
        loadCategoriesWithCards()
        RemoteContentService.shared.prefetchImages(from: allCards)
    }

    private func loadAllCards() {
        allCards = CardLoader.load()
    }

    func loadCategoriesWithCards() {
        let categoriesWithContent = Category.allCases.filter { category in
            allCards.contains(where: { $0.category == category.rawValue })
        }
        self.categoriesWithCards = categoriesWithContent
    }

    func cards(for category: Category?) -> [Card] {
        guard let category = category else { return allCards }
        return allCards.filter { $0.category == category.rawValue }
    }

    func selectRandomCard() {
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

    func refreshRemoteContentOnce() async {
        guard !didRunRefresh else { return }
        didRunRefresh = true
        await refreshRemoteContent()
    }

    func refreshRemoteContent() async {
        do {
            let didUpdate = try await RemoteContentService.shared.refreshIfNeeded()
            if didUpdate {
                loadAllCards()
                loadCategoriesWithCards()
                RemoteContentService.shared.prefetchImages(from: allCards)
                print("🌐 Контент обновлён и перезагружен")
            } else {
                print("🌐 Обновлений нет")
            }
        } catch {
            print("🌐 Ошибка обновления контента: \(error)")
        }
    }
}
