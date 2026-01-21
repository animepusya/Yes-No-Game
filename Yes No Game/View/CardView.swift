//
//  CardView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardViewModel
    @State private var isAnswerExpanded = false
    @State private var isButtonDisabled = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            if let card = viewModel.currentCard {
                
                VStack(alignment: .leading,spacing: 20) {
                    
                    HStack(spacing: 10) {
                        
                        DirectionalChipButton(
                            title: "Назад",
                            direction: .back,
                            action: { dismiss() },
                            style: .neutral
                        )
                        
                        Spacer()
                        
                        if viewModel.isRandomMode {
                            DirectionalChipButton(
                                title: "Следующая",
                                direction: .forward,
                                action: {
                                    guard !isButtonDisabled else { return }
                                    
                                    isButtonDisabled = true
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        viewModel.nextCard()
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                        isButtonDisabled = false
                                    }
                                },
                                style: .accent,
                                isDisabled: isButtonDisabled
                            )
                        }
                    }
                    .padding([.top, .horizontal])
                    
                    Text(card.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.black.opacity(0.5))
                                .shadow(radius: 5)
                        )
                        .padding(.horizontal)
                    
                    Text(card.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.black.opacity(0.5))
                                .shadow(radius: 5)
                        )
                        .padding(.horizontal)
                    
                    if viewModel.showHint {
                        Text(card.hint)
                            .font(.body)
                            .foregroundColor(.yellow)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.black.opacity(0.5))
                                    .shadow(radius: 5)
                            )
                            .padding(.horizontal)
                            .transition(.opacity.combined(with: .move(edge: .leading)))
                    }
                    
                    Spacer()
                    
                    ButtonView(
                        title: viewModel.showHint ? "Скрыть подсказку" : "Подсказка",
                        action: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                viewModel.showHint.toggle()
                            }
                        },
                        backgroundColor: Color.sand.opacity(0.65),
                        isDisabled: false
                    )
                    
                    ExpandableButtonView(
                        title: "Полная история",
                        explanation: card.explanation,
                        backgroundColor: .sand,
                        isExpanded: $isAnswerExpanded
                    )
                }
                .background(
                    ZStack {
                        if let url = card.imageUrl, !url.isEmpty {
                            RemoteCardImage(urlString: url)
                        } else if let name = card.imageName, !name.isEmpty {
                            Image(name)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Color.black
                        }
                        Color.black.opacity(0.4)
                    }
                        .ignoresSafeArea()
                )
                .animation(.easeInOut(duration: 0.4), value: viewModel.showHint)
                
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    let allCards = CardLoader.load()
    let militaryCards = allCards.filter { $0.category == Category.military.rawValue }
    CardView(viewModel: CardViewModel(cards: militaryCards))
}

