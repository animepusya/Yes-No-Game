//
//  MainView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 29.07.2025.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.categoriesWithCards, id: \.self) { category in
                    CategoryScrollView(
                        category: category,
                        cards: viewModel.cards(for: category),
                        onOpenCategory: { viewModel.requestOpenCategory($0) },
                        onOpenCard: { card, cat in viewModel.requestOpenCard(card, in: cat) }
                    )
                }
            }
            .padding(.vertical)
        }
        .task {
            await viewModel.refreshRemoteContentOnce()
        }
        .background(
            Image("mainmenu")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}

