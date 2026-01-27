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
            
            Text("spoiler.title")
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
                    Text("spoiler.continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.sand)
                        .foregroundStyle(Color.black.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Button(action: onDontShowAgain) {
                    Text("spoiler.dont_show_again")
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
    }
    
    private var message: String {
        switch category {
        case .anime:
            return """
spoiler.message.anime
"""
        case .films:
            return """
spoiler.message.films
"""
        case .cartoons:
            return """
spoiler.message.cartoons
"""
        default:
            return """
    spoiler.message.default
"""
        }
    }
}

#Preview {
    SpoilerWarningSheet(category: .anime, onContinue: {}, onDontShowAgain: {})
}

