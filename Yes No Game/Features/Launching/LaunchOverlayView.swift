//
//  LaunchOverlayView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 21.01.2026.
//

import SwiftUI

struct LaunchOverlayView: View {
    let onFinished: () -> Void
    @StateObject private var viewModel = LaunchOverlayViewModel()

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("mainmenu")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()

                Image("iconOnLaunch")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .scaleEffect(viewModel.logoScale)
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .opacity(viewModel.overlayOpacity)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.start {
                onFinished()
            }
        }
        .accessibilityHidden(true)
        .allowsHitTesting(false)
    }
}

#Preview {
    LaunchOverlayView(onFinished: {})
}

