//
//  VideoLaunchScreenView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 08.08.2025.
//

import SwiftUI
import AVKit

struct VideoLaunchScreenView: View {
    @State private var player = AVPlayer()

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                if let url = Bundle.main.url(forResource: "animated", withExtension: "mp4") {
                    player = AVPlayer(url: url)
                    player.play()
                    player.isMuted = true
                }
            }
            .clipped()
            .ignoresSafeArea()
            .scaledToFill()

    }
}

#Preview {
    VideoLaunchScreenView()
}
