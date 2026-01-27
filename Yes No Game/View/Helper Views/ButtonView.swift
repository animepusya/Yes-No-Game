//
//  ButtonView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 28.07.2025.
//

import SwiftUI

struct ButtonView: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var backgroundColor: Color = .sand
    var isDisabled: Bool = false
    
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.black.opacity(0.85))
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(backgroundColor.opacity(isDisabled ? 0.45 : 1))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
        }
        .disabled(isDisabled)
    }
}

#Preview {
    ButtonView(title: "Жми", action: { print("Кнопка работает") })
}
