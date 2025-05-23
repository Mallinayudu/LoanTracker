//
//  LaunchScreen.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 23/05/25.
//

import SwiftUI

struct LaunchScreen: View {
    
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
                    
                    Text("LoanTrack")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Simplify Your Loan Management")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text("Track • Manage • Organize")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .ignoresSafeArea()
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
