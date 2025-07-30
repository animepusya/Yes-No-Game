//
//  MainViewModel.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 30.07.2025.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var categoriesWithCards: [Category] = []

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
}
