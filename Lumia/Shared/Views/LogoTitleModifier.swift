//
//  LogoTitleModifier.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 19.09.2025.
//

import SwiftUI

struct LogoTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("logo-lumia2")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func withLogoTitle() -> some View {
        self.modifier(LogoTitleModifier())
    }
}
