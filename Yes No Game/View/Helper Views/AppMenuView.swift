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
                    "Категории",
                    systemImage: selectedSection == .categories ? "checkmark.circle.fill" : "list.bullet"
                )
            }
            
            Button {
                onSelectSection(.rules)
            } label: {
                Label(
                    "Правила игры",
                    systemImage: selectedSection == .rules ? "checkmark.circle.fill" : "book"
                )
            }

            Button {
                onSelectSection(.about)
            } label: {
                Label(
                    "О приложении",
                    systemImage: selectedSection == .about ? "checkmark.circle.fill" : "info.circle"
                )
            }

            Divider()

            Button(action: onRandomCard) {
                Label("Случайная карточка", systemImage: "dice")
            }

        } label: {
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(
                    selectedSection == .categories ? Color.graphite : Color.accentColor
                )
        }
        .accessibilityLabel("Меню")
    }
}

#Preview {
    AppMenuView(
        selectedSection: .rules,
        onSelectSection: { _ in },
        onRandomCard: { }
    )
}
