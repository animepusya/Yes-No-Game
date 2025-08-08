//
//  AppRootView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 08.08.2025.
//

import SwiftUI

struct AppRootView: View {
    @State private var showLaunchScreen = true

    var body: some View {
        ZStack {
            if showLaunchScreen {
                LaunchScreenView {
                    showLaunchScreen = false
                }
            } else {
                MainView()
            }
        }
    }
}
