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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
            
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
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
                    }
                    .padding()
                }
            }
        }
    }
}



#Preview {
    let sampleCards = CardLoader.load().filter { $0.category == Category.military.rawValue }
    CategoryScrollView(category: .military, cards: sampleCards)
}


