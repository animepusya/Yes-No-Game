//
//  MainView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 29.07.2025.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCard: Card? = nil
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.categoriesWithCards, id: \.self) { category in
                        CategoryScrollView(category: category) { card in
                            selectedCard = card
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Категории")
            .navigationDestination(item: $selectedCard) { card in
                CardView(viewModel: CardViewModel(singleCard: card))
            }
        }
    }
}

#Preview {
    MainView()
}
