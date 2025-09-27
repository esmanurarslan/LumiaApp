//
//  InfoPill.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 20.09.2025.
//

import SwiftUI

struct InfoPill: View {
    let text: String
    var systemImage: String? = nil
    
    var body: some View {
        HStack(spacing: 4) {
            if let systemImage {
                Image(systemName: systemImage)
            }
            Text(text)
                .fontWeight(.semibold)
        }
        .font(.caption)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .foregroundColor(.white)
        .background(Color.white.opacity(0.08))
        .overlay(
            Capsule().stroke(Color.white.opacity(0.2), lineWidth: 0.5)
        )
        .clipShape(Capsule())
    }
}
