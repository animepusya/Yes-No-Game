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
                            NavigationLink {
                                CategoryCardsView(
                                    category: category,
                                    cards: viewModel.cards(for: category)
                                )
                            } label: {
                                CategoryScrollView(
                                    category: category,
                                    cards: viewModel.cards(for: category)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical)
                }
                
                ButtonView(
                    title: "Случайная карточка",
                    action: {
                        viewModel.selectRandomCard()
                    },
                    backgroundColor: .teal
                )
            }
            .navigationTitle("Категории")
            .background(
                Image("mainmenu")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationDestination(item: $viewModel.selectedCard) { card in
                            CardView(
                                viewModel: CardViewModel(
                                    singleCard: card,
                                    allCards: viewModel.allCards,
                                    isRandomMode: viewModel.isRandomMode
                                )
                            )
                        }
        }
    }
}



#Preview {
    MainView()
}
