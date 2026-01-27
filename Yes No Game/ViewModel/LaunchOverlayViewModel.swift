//
//  LaunchOverlayViewModel.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 21.01.2026.
//

import Foundation
import SwiftUI

@MainActor
final class LaunchOverlayViewModel: ObservableObject {
    @Published var overlayOpacity: Double = 1.0
    @Published var logoScale: CGFloat = 1.0

    private let hold: UInt64 = 900_000_000
    private let duration: Double = 0.55

    func start(onFinished: @escaping () -> Void) {
        Task {
            try? await Task.sleep(nanoseconds: hold)

            withAnimation(.easeInOut(duration: duration)) {
                overlayOpacity = 0.0
                logoScale = 1.04
            }

            try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            onFinished()
        }
    }
}

