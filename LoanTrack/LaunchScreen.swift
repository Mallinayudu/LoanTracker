//
//  LaunchScreen.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 23/05/25.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isAnimating = false
    @State private var iconScale: CGFloat = 0.3
    @State private var titleOpacity: Double = 0
    @State private var subtitleOpacity: Double = 0
    @State private var taglineOpacity: Double = 0
    
    var body: some View {
        ZStack {
            Color(.green)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "dollarsign.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .scaleEffect(iconScale)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: iconScale)
                
                Text("LoanTrack")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(titleOpacity)
                    .animation(.easeIn.delay(0.4), value: titleOpacity)
                
                Text("Simplify Your Loan Management")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.9))
                    .opacity(subtitleOpacity)
                    .animation(.easeIn.delay(0.6), value: subtitleOpacity)
                
                Text("Track • Manage • Organize")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .opacity(taglineOpacity)
                    .animation(.easeIn.delay(0.8), value: taglineOpacity)
            }
            .ignoresSafeArea()
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Start the animation sequence
        withAnimation {
            iconScale = 1.0
            titleOpacity = 1
            subtitleOpacity = 1
            taglineOpacity = 1
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
