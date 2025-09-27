//
//  LumiaApp.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import SwiftUI

@main
struct LumiaApp: App {
    init() {
            // Navigation Bar'ın görünümünü genel olarak ayarlıyoruz.
            // Bu ayarlar tüm uygulama için bir kez yapılabilir.
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.theme.backgroundAlt) // Arka plan rengi (Assets: AppBlack)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] //
        
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            // Back button ve toolbar ikonlarının rengi (LogoColor)
            UINavigationBar.appearance().tintColor = UIColor(Color.theme.logo)
            UIBarButtonItem.appearance().tintColor = UIColor(Color.theme.logo)
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CartViewModel())
        }
    }
}
