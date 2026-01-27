//
//  ActionButtonView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 27.01.2026.
//

import SwiftUI

struct ActionButtonView: View {
    enum Style {
        case primary      // sand + black text
        case secondary    // light gray + primary text
    }

    let title: LocalizedStringKey

    var trailingText: String? = nil
    var trailingSystemImage: String? = nil

    var style: Style = .primary
    var isDisabled: Bool = false
    var isLoading: Bool = false

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(foregroundStyle)

                Spacer()

                if isLoading {
                    ProgressView()
                        .controlSize(.small)
                } else if let trailingText {
                    Text(trailingText)
                        .font(.headline)
                        .opacity(0.85)
                        .foregroundStyle(foregroundStyle)
                } else if let trailingSystemImage {
                    Image(systemName: trailingSystemImage)
                        .opacity(0.85)
                        .foregroundStyle(foregroundStyle)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 14)
            .background(backgroundStyle.opacity(isDisabled ? 0.45 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .disabled(isDisabled || isLoading)
    }

    private var backgroundStyle: Color {
        switch style {
        case .primary:
            return .sand
        case .secondary:
            return Color.black.opacity(0.08)
        }
    }

    private var foregroundStyle: Color {
        switch style {
        case .primary:
            return Color.black.opacity(0.85)
        case .secondary:
            return Color.primary
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        ActionButtonView(title: "Unlock category", trailingText: "$1.99", style: .primary, action: {})
        ActionButtonView(title: "Restore purchases", trailingSystemImage: "arrow.clockwise", style: .secondary, action: {})
        ActionButtonView(title: "Loading...", style: .primary, isLoading: true, action: {})
    }
    .padding()
}
