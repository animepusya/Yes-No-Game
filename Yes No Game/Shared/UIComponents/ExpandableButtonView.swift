//
//  ExpandableButton.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 30.07.2025.
//

import SwiftUI

struct ExpandableButtonView: View {
    let title: LocalizedStringKey
    let explanation: String
    let backgroundColor: Color
    @Binding var isExpanded: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.35)) {
                isExpanded.toggle()
            }
        }) {
            VStack(spacing: 10) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.85))

                if isExpanded {
                    Text(explanation)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.35))
                        )
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ExpandableButtonPreview()
}

struct ExpandableButtonPreview: View {
    @State private var isExpanded = false

    var body: some View {
        ExpandableButtonView(
            title: "card.full_story",
            explanation: "Text tipa explanation i ewe bolwe texta dl9 primera choto ya ne ponyal pochemu tut vse tak krasivo a pri ispolzovanii kakoy to trash proishodit i ne tak kruta srazu vyglyadit a net vse taki tut toje trash mne nujen .alignment and .padding",
            backgroundColor: .blue,
            isExpanded: $isExpanded
        )
        .padding()
        .background(Color.gray.opacity(0.15))
    }
}
