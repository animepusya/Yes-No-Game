//
//  SpoilerWarningSheet.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 25.01.2026.
//

import SwiftUI

struct SpoilerWarningSheet: View {
    let category: Category
    let onContinue: () -> Void
    let onDontShowAgain: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .fill(Color.secondary.opacity(0.25))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            Text("Возможны спойлеры")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Text(message)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
            
            VStack(spacing: 10) {
                Button(action: onContinue) {
                    Text("Понятно, продолжить")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.sand)
                        .foregroundStyle(Color.black.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Button(action: onDontShowAgain) {
                    Text("Не показывать снова")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.black.opacity(0.08))
                        .foregroundStyle(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 18)
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
    
    private var message: String {
        switch category {
        case .anime:
            return """
В этой категории есть истории,
основанные на сюжетах аниме.
Они могут содержать спойлеры.
"""
        case .films:
            return """
В этой категории есть истории,
основанные на сюжетах фильмов.
Они могут содержать спойлеры.
"""
        case .cartoons:
            return """
В этой категории есть истории,
основанные на сюжетах мультфильмов
и мультсериалов. Возможны спойлеры.
"""
        default:
            return """
    В этой категории возможны спойлеры.
"""
        }
    }
}

#Preview {
    SpoilerWarningSheet(category: .anime, onContinue: {}, onDontShowAgain: {})
}

