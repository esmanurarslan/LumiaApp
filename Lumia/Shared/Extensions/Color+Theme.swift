//
//  Color+Theme.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 20.09.2025.
//

import SwiftUI

struct AppColorTheme {
    let background: Color = Color("AppDarkBlue")
    let backgroundAlt: Color = Color("AppBlack")
    let accent: Color = Color("AppPink")
    let accentSystem: Color = Color("AccentColor")
    let logo: Color = Color("LogoColor")
}

extension Color {
    static let theme = AppColorTheme()
}
