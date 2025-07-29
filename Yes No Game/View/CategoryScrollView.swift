//
//  ContentView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import SwiftUI

struct CategoryScrollView: View {
    let category: Category
    @StateObject private var viewModel: CardViewModel
    var onCardSelected: (Card) -> Void

    init(category: Category, onCardSelected: @escaping (Card) -> Void) {
        self.category = category
        self.onCardSelected = onCardSelected
        _viewModel = StateObject(wrappedValue: CardViewModel(category: category))
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
    CategoryScrollView(category: .military, onCardSelected: { _ in })
}

