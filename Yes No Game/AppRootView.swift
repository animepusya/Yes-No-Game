//
//  AppRootView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 08.08.2025.
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

struct AppRootView: View {
    @State private var showLaunchScreen = true
    
    @State private var selectedSection: AppSection = .categories
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(selectedSection.titleKey)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.graphite)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        AppMenuView(
                            selectedSection: selectedSection,
                            onSelectSection: { selected in
                                selectedSection = selected
                            },
                            onRandomCard: {
                                mainViewModel.selectRandomCard()
                            }
                        )
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
                .navigationDestination(item: $mainViewModel.selectedCategory) { category in
                    CategoryCardsView(
                        category: category,
                        cards: mainViewModel.cards(for: category)
                    )
                }
                .navigationDestination(item: $mainViewModel.selectedCard) { card in
                    CardView(
                        viewModel: CardViewModel(
                            singleCard: card,
                            allCards: mainViewModel.allCards,
                            isRandomMode: mainViewModel.isRandomMode
                        )
                    )
                }
                .sheet(item: $mainViewModel.spoilerPrompt) { prompt in
                    SpoilerWarningSheet(
                        category: prompt.category,
                        onContinue: { mainViewModel.spoilerContinue(dontShowAgain: false) },
                        onDontShowAgain: { mainViewModel.spoilerContinue(dontShowAgain: true) }
                    )
                }
        }
        .overlay {
            if showLaunchScreen {
                LaunchOverlayView {
                    showLaunchScreen = false
                }
                .transition(.identity)
                .zIndex(1)
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch selectedSection {
        case .categories:
            MainView(viewModel: mainViewModel)
        case .settings:
            SettingsView()
        case .rules:
            RulesView()
        }
    }
}
