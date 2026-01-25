//
//  CategoryScrollView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import SwiftUI

struct CategoryScrollView: View {
    let category: Category
    let cards: [Card]
    
    let onOpenCategory: (Category) -> Void
    let onOpenCard: (Card, Category) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Button {
                onOpenCategory(category)
            } label: {
                HStack {
                    Text(category.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.graphite)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.graphite.opacity(0.35))
                        .padding(.trailing, 20)
                }
            }
            .buttonStyle(.plain)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(cards) { card in
                        Button {
                            onOpenCard(card, category)
                        } label: {
                            IconCardView(card: card)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    let sampleCards = CardLoader.load().filter { $0.category == Category.military.rawValue }
    CategoryScrollView(
        category: .military,
        cards: sampleCards,
        onOpenCategory: { _ in },
        onOpenCard: { _, _ in }
    )
}
