//
//  ChipButton.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 21.01.2026.
//

import SwiftUI

struct DirectionalChipButton: View {
    enum Direction {
        case back
        case forward
    }

    let title: LocalizedStringKey
    let direction: Direction
    let action: () -> Void

    var style: Style = .neutral
    var isDisabled: Bool = false

    enum Style {
        case neutral
        case accent
    }

    var body: some View {
        Button(action: action) {
            content
                .foregroundStyle(foregroundColor)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(background)
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
                .opacity(isDisabled ? 0.55 : 1)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
    }

    @ViewBuilder
    private var content: some View {
        switch direction {
        case .back:
            HStack(spacing: 6) {
                Image(systemName: "chevron.left")
                Text(title)
                    .font(.subheadline.weight(.semibold))
            }

        case .forward:
            HStack(spacing: 6) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Image(systemName: "chevron.right")
            }
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .neutral:
            return .white
        case .accent:
            return Color.black.opacity(0.85)
        }
    }

    private var background: some View {
        Group {
            switch style {
            case .neutral:
                Capsule().fill(Color.black.opacity(0.35))
            case .accent:
                Capsule().fill(Color.sand)
            }
        }
    }
}
#Preview {
    DirectionalChipButton(title: "Hello", direction: .back, action: {})
}
