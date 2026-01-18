//
//  RemoteCardImage.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 18.01.2026.
//

import SwiftUI

struct RemoteCardImage: View {
    let urlString: String
    @StateObject private var loader = RemoteImageLoader()

    var body: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .opacity(0.15)
                    .overlay {
                        if loader.isLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .opacity(0.4)
                        }
                    }
            }
        }
        .clipped()
        .task(id: urlString) { // важно: id, чтобы при смене url перезагрузилось один раз
            await loader.load(from: urlString)
        }
    }
}
