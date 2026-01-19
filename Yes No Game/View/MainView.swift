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
