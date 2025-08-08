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
                                    cards: viewModel.cards(for: category),
                                    onCardSelected: { card in
                                        viewModel.selectSpecificCard(card)
                                    }
                                )
                            } label: {
                                CategoryScrollView(category: category, cards: viewModel.cards(for: category)) { card in
                                    viewModel.selectSpecificCard(card)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    .padding(.vertical)
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
                    CardView(viewModel: CardViewModel(singleCard: card, allCards: viewModel.allCards, isRandomMode: viewModel.isRandomMode))
                }
                
            }
            .background(
                Image("mainmenu")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}



#Preview {
    MainView()
}
