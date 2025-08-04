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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            if let card = viewModel.currentCard {
                
                VStack(alignment: .leading,spacing: 20) {
                    
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "chevron.left")
                                Text("Вернуться")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.blue.opacity(0.5))
                                    .shadow(radius: 5)
                            )
                            .cornerRadius(16)
                            .shadow(color: .blue.opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                        
                        Spacer()
                        
                        if viewModel.isRandomMode {
                            Button(action: {
                                withAnimation {
                                    viewModel.nextCard()
                                }
                            }) {
                                HStack(spacing: 6) {
                                    Text("Следующая карточка")
                                    Image(systemName: "arrow.right")
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.green.opacity(0.5))
                                        .shadow(radius: 5)
                                )
                                .cornerRadius(16)
                                .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 5)
                            }
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
                        backgroundColor: .blue,
                        isDisabled: false
                    )
                    
                    ExpandableButtonView(
                        title: "Полная история",
                        explanation: card.explanation,
                        backgroundColor: .blue,
                        isExpanded: $isAnswerExpanded)
                }
                .background(
                    Image(card.imageName)
                        .resizable()
                        .scaledToFill()
                        .overlay(Color.black.opacity(0.4))
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

