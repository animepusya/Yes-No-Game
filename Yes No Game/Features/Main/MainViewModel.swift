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
    @Published var spoilerPrompt: SpoilerPrompt?
    
    @Published private(set) var allCards: [Card] = []
    
    private var didRunRefresh = false
    private var pendingRoute: Route?
    
    struct SpoilerPrompt: Identifiable {
        let category: Category
        var id: String { category.rawValue }
    }
    
    init() {
        loadAllCards()
        loadCategoriesWithCards()
        CardsRepository.shared.prefetchImages(from: allCards)
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
    
    // MARK: - Spoiler categories
    
    private var spoilerCategories: Set<Category> { [.anime, .films, .cartoons] }
    
    private func shouldShowSpoilerWarning(for category: Category) -> Bool {
        guard spoilerCategories.contains(category) else { return false }
        return !SpoilerWarningStore.shouldSkipWarning(for: category)
    }

    // MARK: - Routes (NavigationPath)

    func makeCategoryRoute(_ category: Category) -> Route? {
        if shouldShowSpoilerWarning(for: category) {
            pendingRoute = .category(category)
            spoilerPrompt = SpoilerPrompt(category: category)
            return nil
        }
        return .category(category)
    }

    func makeCardRoute(_ card: Card, in category: Category, isRandomMode: Bool) -> Route? {
        let all = cards(for: category)

        if shouldShowSpoilerWarning(for: category) {
            pendingRoute = .card(card, allCards: all, isRandomMode: isRandomMode)
            spoilerPrompt = SpoilerPrompt(category: category)
            return nil
        }

        return .card(card, allCards: all, isRandomMode: isRandomMode)
    }

    func makeRandomCardRoute() -> Route? {
        let filteredCards = allCards.filter { card in
            categoriesWithCards.contains(where: { $0.rawValue == card.category })
        }
        guard let random = filteredCards.randomElement() else { return nil }

        guard let category = Category.allCases.first(where: { $0.rawValue == random.category }) else {
            return .card(random, allCards: allCards, isRandomMode: true)
        }

        return makeCardRoute(random, in: category, isRandomMode: true)
    }

    func consumePendingRoute(dontShowAgain: Bool) -> Route? {
        guard let prompt = spoilerPrompt else { return nil }
        let category = prompt.category
        
        if dontShowAgain {
            SpoilerWarningStore.setSkipWarning(true, for: category)
        }
        
        spoilerPrompt = nil

        let route = pendingRoute
        pendingRoute = nil
        return route
    }
    
    // MARK: - Remote refresh
    
    func refreshRemoteContentOnce() async {
        guard !didRunRefresh else { return }
        didRunRefresh = true
        await refreshRemoteContent()
    }

    func refreshRemoteContent() async {
        do {
            let didUpdate = try await CardsRepository.shared.refreshIfNeeded()
            if didUpdate {
                loadAllCards()
                loadCategoriesWithCards()
                CardsRepository.shared.prefetchImages(from: allCards)
                print("🌐 Контент обновлён и перезагружен")
            } else {
                print("🌐 Обновлений нет")
            }
        } catch {
            print("🌐 Ошибка обновления контента: \(error)")
        }
    }
}
