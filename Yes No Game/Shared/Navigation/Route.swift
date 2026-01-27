//
//  Route.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 28.01.2026.
//

import Foundation

enum Route: Hashable {
    case category(Category)
    case card(Card, allCards: [Card], isRandomMode: Bool)
}
