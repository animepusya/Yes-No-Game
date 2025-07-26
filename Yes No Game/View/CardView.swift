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
                Text(card.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    
                Image(card.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(card.description)
                    .padding()
                
                Button("Подсказка") { viewModel.showHint = true }
                Button("Показать ответ") { viewModel.showAnswer = true }
                Button("Следующая карточка") { viewModel.nextCard() }
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
