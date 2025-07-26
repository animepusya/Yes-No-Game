//
//  ContentView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import SwiftUI

struct CategorySelectionView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Выбери тему")
                    .font(.title)

                ForEach(Category.allCases, id: \.self) { category in
                    NavigationLink(destination: CardView(viewModel: CardViewModel(category: category))) {
                        Text(category.rawValue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }

                NavigationLink(destination: CardView(viewModel: CardViewModel(category: nil))) {
                    Text("Случайная история")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CategorySelectionView()
}
