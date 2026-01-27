//
//  AppMenuView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 19.01.2026.
//

import SwiftUI

struct AppMenuView: View {
    let selectedSection: AppSection
    let onSelectSection: (AppSection) -> Void
    let onRandomCard: () -> Void

    var body: some View {
        Menu {
            Button {
                onSelectSection(.categories)
            } label: {
                Label(
                    "menu.categories",
                    systemImage: selectedSection == .categories ? "checkmark.circle.fill" : "list.bullet"
                )
            }
            
            Button {
                onSelectSection(.rules)
            } label: {
                Label(
                    "menu.rules",
                    systemImage: selectedSection == .rules ? "checkmark.circle.fill" : "book"
                )
            }

            Button {
                onSelectSection(.settings)
            } label: {
                Label(
                    "menu.settings",
                    systemImage: selectedSection == .settings ? "checkmark.circle.fill" : "gearshape"
                )
            }

            Divider()

            Button(action: onRandomCard) {
                Label("menu.random_card", systemImage: "dice")
            }

        } label: {
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(
                    selectedSection == .categories ? Color.graphite : Color.accentColor
                )
        }
        .accessibilityLabel("menu.accessibility")
    }
}

#Preview {
    AppMenuView(
        selectedSection: .rules,
        onSelectSection: { _ in },
        onRandomCard: { }
    )
}
