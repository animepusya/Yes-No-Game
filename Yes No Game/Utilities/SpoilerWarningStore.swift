//
//  SpoilerWarningStore.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 25.01.2026.
//

import Foundation

struct SpoilerWarningStore {
    private static let prefix = "spoiler_warning_skip_"

    static func shouldSkipWarning(for category: Category) -> Bool {
        UserDefaults.standard.bool(forKey: key(for: category))
    }

    static func setSkipWarning(_ skip: Bool, for category: Category) {
        UserDefaults.standard.set(skip, forKey: key(for: category))
    }

    private static func key(for category: Category) -> String {
        prefix + category.rawValue
    }
}
