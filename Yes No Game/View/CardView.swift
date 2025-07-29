//
//  CardView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        VStack {
            if let card = viewModel.currentCard {
                
                ZStack {
                    Image(card.imageName)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all) // чтобы заняло весь экран
                        .overlay(Color.black.opacity(0.4)) // затемнение для читаемости текста
                    
                    
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
                                .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                        
                        if viewModel.showAnswer {
                            Text(card.explanation)
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
                                .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                        
                        Spacer()
                        
                        ButtonView(
                            title: "Подсказка",
                            action: {
                                withAnimation {
                                    viewModel.showHint = true
                                }
                            },
                            backgroundColor: .blue,
                            isDisabled: viewModel.showHint
                        )
                        
                        ButtonView(
                            title: "Полная история",
                            action: {
                                withAnimation {
                                    viewModel.showAnswer = true
                                }
                            },
                            backgroundColor: .green,
                            isDisabled: viewModel.showAnswer
                        )
                    }
                    .padding(50)
                    
                }
            }
        }
    }
}

#Preview {
    CardView(viewModel: MockCardViewModel())
}
