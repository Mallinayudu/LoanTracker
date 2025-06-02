//
//  LoanTrackApp.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 19/05/25.
//

import SwiftUI

@main
struct LoanTrackApp: App {
    @State private var isShowingLaunchScreen = true
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeScreen()
                        .scaleEffect(isShowingLaunchScreen ? 0.95 : 1.0)
                        .opacity(isShowingLaunchScreen ? 0 : 1.0)
                        .animation(.easeOut(duration: 0.4), value: isShowingLaunchScreen)
                }
                
                if isShowingLaunchScreen {
                    LaunchScreen()
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .animation(.easeOut(duration: 0.4), value: scale)
                        .zIndex(1)
                }
            }
            .onAppear {
                // First let the launch screen animations complete
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    // Start transition animation
                    withAnimation(.easeInOut(duration: 0.4)) {
                        scale = 1.1
                        opacity = 0
                    }
                    
                    // Remove launch screen after animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        isShowingLaunchScreen = false
                    }
                }
            }
        }
    }
}
