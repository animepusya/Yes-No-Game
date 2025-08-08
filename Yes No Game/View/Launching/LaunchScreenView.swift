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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        opacity = 0
                        scale = 1.4
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                    onFinished()
                }
            }
    }
}

#Preview {
    LaunchScreenView(onFinished: {  })
}
