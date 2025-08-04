//
//  ExpandableButton.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 30.07.2025.
//

import SwiftUI

struct ExpandableButtonView: View {
    let title: String
    let explanation: String
    let backgroundColor: Color
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }) {
                VStack(spacing: 8) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    if isExpanded {
                        Text(explanation)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .scaleEffect(0.9)
                            .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .scale.combined(with: .opacity)))
                    }
                }
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(16)
                .shadow(color: backgroundColor.opacity(0.4), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ExpandableButtonPreview()
}

struct ExpandableButtonPreview: View {
    @State private var isExpanded = false

    var body: some View {
        ExpandableButtonView(
            title: "Meme",
            explanation: "Text tipa explanation i ewe bolwe texta dl9 primera choto ya ne ponyal pochemu tut vse tak krasivo a pri ispolzovanii kakoy to trash proishodit i ne tak kruta srazu vyglyadit a net vse taki tut toje trash mne nujen .alignment and .padding",
            backgroundColor: .blue,
            isExpanded: $isExpanded
        )
        .padding()
        .background(Color.white)
    }
}
