//
//  ContentView.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @State private var showSplash: Bool = true
    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                NavigationView { CartView() }
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }
            }
            // Success Toast (Splash üzerindeyken göstermeye gerek yok)
            if cartVM.showSuccessToast && !showSplash {
                SuccessToastView(message: cartVM.toastMessage)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            if showSplash {
                SplashView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation(.easeOut(duration: 0.6)) { showSplash = false }
            }
        }
        .tint(Color.theme.logo)
    }
}

#Preview {
    ContentView().environmentObject(CartViewModel())
}
