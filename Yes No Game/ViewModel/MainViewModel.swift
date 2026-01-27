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
    @Published var selectedCategory: Category?
    @Published var selectedCard: Card?
    @Published var isRandomMode: Bool = false
    @Published var spoilerPrompt: SpoilerPrompt?
    
    @Published private(set) var allCards: [Card] = []
    
    private var didRunRefresh = false
    
    private enum PendingNavigation {
        case category(Category)
        case card(Card, allCards: [Card], isRandomMode: Bool)
    }
    private var pendingNavigation: PendingNavigation?
    
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
    
    // MARK: - Requests from Views (MVVM)
    
    func requestOpenCategory(_ category: Category) {
        if shouldShowSpoilerWarning(for: category) {
            pendingNavigation = .category(category)
            spoilerPrompt = SpoilerPrompt(category: category)
            return
        }
        selectedCategory = category
    }
    
    func requestOpenCard(_ card: Card, in category: Category) {
        let categoryCards = cards(for: category)
        
        if shouldShowSpoilerWarning(for: category) {
            pendingNavigation = .card(card, allCards: categoryCards, isRandomMode: false)
            spoilerPrompt = SpoilerPrompt(category: category)
            return
        }
        
        selectedCard = card
        isRandomMode = false
    }
    
    func spoilerContinue(dontShowAgain: Bool) {
        guard let prompt = spoilerPrompt else { return }
        let category = prompt.category
        
        if dontShowAgain {
            SpoilerWarningStore.setSkipWarning(true, for: category)
        }
        
        spoilerPrompt = nil
        
        guard let pending = pendingNavigation else { return }
        pendingNavigation = nil
        
        switch pending {
        case .category(let cat):
            selectedCategory = cat
            
        case .card(let card, _, let randomMode):
            selectedCard = card
            isRandomMode = randomMode
        }
    }
    
    // MARK: - Random card
    
    func selectRandomCard() {
        let filteredCards = allCards.filter { card in
            categoriesWithCards.contains(where: { $0.rawValue == card.category })
        }
        guard let random = filteredCards.randomElement() else { return }
        
        if let category = Category.allCases.first(where: { $0.rawValue == random.category }) {
            if shouldShowSpoilerWarning(for: category) {
                pendingNavigation = .card(random, allCards: cards(for: category), isRandomMode: true)
                spoilerPrompt = SpoilerPrompt(category: category)
                return
            }
        }
        
        selectedCard = random
        isRandomMode = true
    }
    
    func selectSpecificCard(_ card: Card) {
        selectedCard = card
        isRandomMode = false
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
