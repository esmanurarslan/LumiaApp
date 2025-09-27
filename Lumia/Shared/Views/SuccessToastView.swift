//
//  SuccessToastView.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 21.09.2025.
//

import SwiftUI

struct SuccessToastView: View {
    let message: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.white)
            Text(message)
                .foregroundColor(.white)
                .font(.subheadline.weight(.semibold))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.theme.accent.opacity(0.95))
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.25), radius: 10, y: 6)
        .padding(.top, 12)
    }
}

#Preview {
    ZStack(alignment: .top) {
        Color.black.ignoresSafeArea()
        SuccessToastView(message: "Dune sepete eklendi")
    }
}
