//
//  RulesView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 19.01.2026.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                sectionCard {
                    Text("rules.how_to_play.title")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    rules.how_to_play.body
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("rules.start.title")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    rules.start.body
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("rules.goal.title")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    rules.goal.body
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("rules.example.title")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    rules.example.body
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("rules.why.title")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    rules.why.body
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("rules.where.title")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    rules.where.body
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
            .padding(.horizontal, 16)
        }
        .background(
            Image("mainmenu")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }

    private func sectionCard<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.5))
                .shadow(radius: 5)
        )
    }
}

#Preview {
    RulesView()
}

