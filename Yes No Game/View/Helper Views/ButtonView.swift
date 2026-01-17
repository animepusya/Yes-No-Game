//
//  ButtonView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 28.07.2025.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    let action: () -> Void
    var backgroundColor: Color = .sand
    var isDisabled: Bool = false
    
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(isDisabled ? Color.gray : backgroundColor)
                .cornerRadius(16)
                .shadow(color: backgroundColor.opacity(0.25), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
        }
        .disabled(isDisabled)
    }
}

#Preview {
    ButtonView(title: "Жми", action: { print("Кнопка работает") })
}
