//
//  MainView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 29.07.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.categoriesWithCards, id: \.self) { category in
                            CategoryScrollView(category: category) { card in
                                viewModel.selectSpecificCard(card)
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.bottom, 100)
                }

                ButtonView(title: "Случайная карточка") {
                    viewModel.selectRandomCard()
                }
            }
            .navigationTitle("Категории")
            .navigationDestination(
                isPresented: Binding<Bool>(
                    get: { viewModel.selectedCard != nil },
                    set: { if !$0 { viewModel.selectedCard = nil } }
                )
            ) {
                if let card = viewModel.selectedCard {
                    CardView(viewModel: CardViewModel(singleCard: card, isRandomMode: viewModel.isRandomMode))
                }
            }
        }
    }
}



#Preview {
    MainView()
}
