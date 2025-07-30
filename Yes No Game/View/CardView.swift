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
    
    var body: some View {
        VStack {
            if let card = viewModel.currentCard {
                
                VStack(alignment: .leading,spacing: 20) {
                    
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
                    
                    ExpandableButton(
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
    }
}

#Preview {
    CardView(viewModel: CardViewModel(category: .military))
}
