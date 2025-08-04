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
    var onCardSelected: (Card) -> Void
    
    @StateObject private var viewModel: CardViewModel
    
    init(category: Category, cards: [Card], onCardSelected: @escaping (Card) -> Void) {
        self.category = category
        self.cards = cards
        self.onCardSelected = onCardSelected
        _viewModel = StateObject(wrappedValue: CardViewModel(cards: cards))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(category.title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.cards) { card in
                        IconCardView(card: card)
                            .onTapGesture {
                                onCardSelected(card)
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
    CategoryScrollView(category: .military, cards: sampleCards, onCardSelected: { _ in })
}


