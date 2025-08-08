//
//  LaunchScreenView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 08.08.2025.
//

import SwiftUI

struct LaunchScreenView: View {
    var onFinished: () -> Void

    @State private var opacity = 1.0
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VideoLaunchScreenView()
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.smooth(duration: 0.3)) {
                        opacity = 0
                        scale = 3
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.12) {
                    onFinished()
                }
            }
    }
}

#Preview {
    LaunchScreenView(onFinished: {  })
}
