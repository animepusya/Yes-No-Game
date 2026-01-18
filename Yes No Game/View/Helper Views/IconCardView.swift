//
//  IconCardView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 28.07.2025.
//

import SwiftUI

struct IconCardView: View {
    let card: Card
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack {
                if let url = card.imageUrl, !url.isEmpty {
                    RemoteCardImage(urlString: url)
                } else if let name = card.imageName, !name.isEmpty {
                    Image(name)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.black.opacity(0.2)
                }
            }
            .frame(width: 160, height: 220)
            .clipped()
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .cornerRadius(16)
            
            Text(card.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(8)
                .shadow(radius: 5)
        }
        .frame(width: 160, height: 220)
        .shadow(radius: 6)
    }
}

#Preview {
    IconCardView(card: Card(category: "Military",
                            title: "Салют",
                            description: "Солдаты стояли на крыше и стреляли в небо. Это спасло город.",
                            hint: "Они стреляли не по врагу.",
                            explanation: "Солдаты запускали сигнальные ракеты, чтобы показать сбитому пилоту, где находится база. Пилот вернулся, сообщил координаты врага — и это спасло город.",
                            imageName: nil,
                            imageUrl: "https://animepusya.github.io/YNG-content/images/missedMeeting.png"))
}
