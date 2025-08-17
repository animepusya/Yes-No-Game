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
                    .padding(.horizontal)
                Spacer()
                Text("Ещё")
                    .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.15))
                        )
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                
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


