//
//  CategoryCardsView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 04.08.2025.
//

import SwiftUI

struct CategoryCardsView: View {
    let category: Category
    let cards: [Card]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(cards) { card in
                    NavigationLink(destination: CardView(viewModel: CardViewModel(singleCard: card, allCards: cards))) {
                        IconCardView(card: card)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    CategoryCardsView(category: .military, cards: [Card(category: "Military",
                                                        title: "Салют",
                                                        description: "Солдаты стояли на крыше и стреляли в небо. Это спасло город.",
                                                        hint: "Они стреляли не по врагу.",
                                                        explanation: "Солдаты запускали сигнальные ракеты, чтобы показать сбитому пилоту, где находится база. Пилот вернулся, сообщил координаты врага — и это спасло город.",
                                                        imageName: "militarySalute")])
}
