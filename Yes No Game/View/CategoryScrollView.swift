//
//  CategoryScrollView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import SwiftUI

struct CategoryScrollView: View {
    @EnvironmentObject private var purchases: PurchaseManager
    @State private var showPaywall = false
    let category: Category
    let cards: [Card]
    
    let onOpenCategory: (Category) -> Void
    let onOpenCard: (Card, Category) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Button {
                if purchases.hasAccess(to: category) {
                    onOpenCategory(category)
                } else {
                    showPaywall = true
                }
            } label: {
                HStack {
                    Text(category.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.graphite)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    if !purchases.hasAccess(to: category) {
                        HStack(spacing: 6) {
                            Image(systemName: "lock.fill")
                                .font(.caption)
                                .foregroundColor(.graphite.opacity(0.5))
                            Text(purchases.priceText(for: category.productId ?? "") ?? "$1.99")
                                .font(.caption)
                                .foregroundColor(.graphite.opacity(0.6))
                        }
                    }
                    
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.graphite.opacity(0.35))
                        .padding(.trailing, 20)
                }
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showPaywall) {
                PaywallView(category: category)
                    .environmentObject(purchases)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(cards) { card in
                        Button {
                            if purchases.hasAccess(to: category) {
                                onOpenCard(card, category)
                            } else {
                                showPaywall = true
                            }
                        } label: {
                            IconCardView(card: card)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    let sampleCards = CardLoader.load().filter { $0.category == Category.military.rawValue }
    CategoryScrollView(
        category: .military,
        cards: sampleCards,
        onOpenCategory: { _ in },
        onOpenCard: { _, _ in }
    )
}
