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
                            
                            Spacer()
                            
                            ButtonView(
                                title: "Подсказка",
                                action: { viewModel.showHint = true },
                                backgroundColor: .blue
                            )

                            ButtonView(
                                title: "Полная история",
                                action: { viewModel.showAnswer = true },
                                backgroundColor: .green
                            )
                        }
                        .padding(50)
                    
                }
            }
        }
        // .sheet(isPresented: $viewModel.showHint) {
        //    HintView(text: viewModel.currentCard?.hint ?? "")
    }
    // .sheet(isPresented: $viewModel.showAnswer) {
    //    AnswerView(text: viewModel.currentCard?.answer ?? "")
}

#Preview {
    CardView(viewModel: MockCardViewModel())
}
