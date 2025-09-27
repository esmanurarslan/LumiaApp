//
//  CartView.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel
    
    var body: some View {
        Group {
            if cartVM.isLoading && cartVM.items.isEmpty { // Sadece ilk yüklemede tam ekran loading göster
                ProgressView("Cart is loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.theme.backgroundAlt)
            } else {
                if cartVM.items.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "cart")
                            .font(.system(size: 56))
                            .foregroundColor(Color.theme.logo)
                        Text("Your cart is empty")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.theme.backgroundAlt)
                } else {
                    List {
                        ForEach(cartVM.items) { item in
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: Endpoints.getMovieImage(named: item.image))) { image in
                                    image.resizable().scaledToFill()
                                } placeholder: {
                                    Rectangle().fill(Color.gray.opacity(0.2))
                                }
                                .frame(width: 56, height: 84)
                                .clipped()
                                .cornerRadius(6)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("\(Formatting.currency(item.price)) x \(item.orderAmount)")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.85))
                                }
                                Spacer()
                                        
                                HStack(spacing: 12) {
                                    Button {
                                        Task { await cartVM.decreaseQuantity(for: item) }
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .font(.title2)
                                    }
                                    
                                    Text("\(item.orderAmount)")
                                        .font(.headline)
                                        .frame(minWidth: 20)
                                    
                                   
                                }
                                .foregroundColor(Color.theme.logo)
                            }
                            .padding(.vertical, 4)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    Task { await cartVM.delete(cartItem: item) }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .background(Color.theme.backgroundAlt)
                  
                    .refreshable {
                        await cartVM.loadCart(force: true)
                    }
                    .safeAreaInset(edge: .bottom) {
                        if !cartVM.items.isEmpty {
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Text(Formatting.currency(cartVM.totalPrice))
                                    .font(.title3).bold()
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(Color.theme.background)
                        }
                    }
                }
            }
        }
        .withLogoTitle()
        .task {
        
            await cartVM.loadCart()
        }
    }
}

private struct ErrorBanner: View {
    let message: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.white)
            Text(message)
                .foregroundColor(.white)
                .font(.subheadline.weight(.semibold))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
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
    CartView().environmentObject(CartViewModel())
}
