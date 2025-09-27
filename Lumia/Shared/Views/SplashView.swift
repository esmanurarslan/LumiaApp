//
//  SplashView.swift
//  Lumia
//
//  Created by Cascade on 20.09.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundAlt.ignoresSafeArea()
            VStack(spacing: 16) {
                Image("logo-lumia2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity)
                    .scaleEffect(animate ? 1.0 : 0.5)
                    .opacity(animate ? 1.0 : 0.0)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) { animate = true }
        }
    }
}

#Preview {
    SplashView()
}
