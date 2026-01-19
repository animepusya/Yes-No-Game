//
//  AboutView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 19.01.2026.
//

import SwiftUI

struct AboutView: View {
    private var appVersionText: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "—"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "—"
        return "\(version) (\(build))"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                sectionCard {
                    Text("Yes No Game — это набор карточек-загадок (данеток), где нужно угадать историю по короткому описанию. Открывай подсказку, а затем полную историю — и проверяй свою догадку.")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(2)
                }
                
                sectionCard {
                    HStack {
                        Label("Версия", systemImage: "number")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text(appVersionText)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .font(.body)
                }
                
                sectionCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Связаться с разработчиком")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        contactLink(
                            title: "Email",
                            systemImage: "envelope",
                            urlString: "mailto:rus.melanin@mail.ru"
                        )
                        
                        dividerLine()
                        
                        contactLink(
                            title: "GitHub",
                            systemImage: "link",
                            urlString: "https://github.com/animepusya"
                        )
                        
                        dividerLine()
                        
                        contactLink(
                            title: "Telegram",
                            systemImage: "paperplane",
                            urlString: "https://t.me/animepusya"
                        )
                    }
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
    
    private func dividerLine() -> some View {
        Divider().overlay(Color.white.opacity(0.25))
    }
    
    private func contactLink(title: String, systemImage: String, urlString: String) -> some View {
        Link(destination: URL(string: urlString)!) {
            HStack {
                Label(title, systemImage: systemImage)
                Spacer()
                Image(systemName: "arrow.up.right")
                    .opacity(0.9)
            }
            .contentShape(Rectangle())
            .foregroundColor(.white)
        }
    }
}

#Preview {
    AboutView()
}
