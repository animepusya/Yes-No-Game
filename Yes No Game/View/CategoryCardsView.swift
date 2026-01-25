//
//  CategoryCardsView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 04.08.2025.
//

import SwiftUI

struct CategoryCardsView: View {
    @Environment(\.dismiss) private var dismiss

    let category: Category
    let cards: [Card]

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                DirectionalChipButton(
                    title: "Назад",
                    direction: .back,
                    action: { dismiss() },
                    style: .neutral
                )
                Spacer()
            }
            .padding([.top, .horizontal])

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(cards) { card in
                        NavigationLink {
                            CardView(
                                viewModel: CardViewModel(
                                    singleCard: card,
                                    allCards: cards
                                )
                            )
                        } label: {
                            IconCardView(card: card)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .background(
            Image("mainmenu")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    let viewModel = MainViewModel()
    let sampleCategory: Category = .military
    let sampleCards = viewModel.cards(for: sampleCategory)

    CategoryCardsView(
        category: sampleCategory,
        cards: sampleCards,
    )
}
