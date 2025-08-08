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
    var onCardSelected: (Card) -> Void

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                        Text("Вернуться")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.blue.opacity(0.5))
                            .shadow(radius: 5)
                    )
                    .cornerRadius(16)
                    .shadow(color: .blue.opacity(0.4), radius: 10, x: 0, y: 5)
                }

                Spacer()
            }
            .padding([.top, .horizontal])

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(cards) { card in
                        IconCardView(card: card)
                            .onTapGesture {
                                onCardSelected(card)
                            }
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
    let sampleCards = CardLoader.load().filter { $0.category == Category.military.rawValue }
    CategoryScrollView(category: .military, cards: sampleCards, onCardSelected: { _ in })
}
