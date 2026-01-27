//
//  AppSection.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 28.01.2026.
//

import SwiftUI

enum AppSection: Hashable {
    case categories
    case settings
    case rules

    var titleKey: LocalizedStringKey {
        switch self {
        case .categories: return "menu.categories"
        case .settings: return "menu.settings"
        case .rules: return "menu.rules"
        }
    }
}
