//
//  CartViewModel.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation
import SwiftUI

@MainActor
final class CartViewModel: ObservableObject {
    @Published var items: [MovieCart] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showSuccessToast: Bool = false
    @Published var toastMessage: String = ""

    private var isUpdatingCart = false
    
    // --- DEĞİŞİKLİK 1: İlk yüklemenin yapılıp yapılmadığını takip eden bayrak eklendi ---
    private var hasPerformedInitialLoad = false

    private let service: MovieService

    init(service: MovieService = MovieService()) {
        self.service = service
    }

    var totalPrice: Int {
        items.reduce(0) { $0 + ($1.price * $1.orderAmount) }
    }
    
    // --- DEĞİŞİKLİK 2: Fonksiyon, gereksiz yüklemeleri önleyecek şekilde güncellendi ---
    /// Sepeti yükler. `force` parametresi true ise, daha önce yüklenmiş olsa bile yeniden yüklemeyi zorlar.
    func loadCart(force: Bool = false) async {
        // Eğer zorunlu bir yenileme değilse VE ilk yükleme zaten yapıldıysa, fonksiyonu çalıştırma.
        // Bu, sekmeler arası geçişteki "yanıp sönme" sorununu çözer.
        guard force || !hasPerformedInitialLoad else { return }
        
        if isLoading { return }
        
        isLoading = true
        defer { isLoading = false } // Bu satır, fonksiyon hata verse bile isLoading'in false yapılmasını garantiler.
        
        do {
            self.items = try await service.fetchCart()
            // Başarılı bir yüklemeden sonra bayrağı `true` yapıyoruz.
            self.hasPerformedInitialLoad = true
        } catch {
            self.items = []
            // İsteğe bağlı: Gerçek bir ağ hatası varsa kullanıcıya göstermek için errorMessage ayarlanabilir.
            // self.errorMessage = "Sepet yüklenemedi: \(error.localizedDescription)"
        }
    }

    /// Sepetteki bir ürünün miktarını günceller. Tüm işlemlerin merkezidir.
    private func updateCart(for movie: Movies, amountChange: Int) async {
        guard !isUpdatingCart else { return }
        
        isUpdatingCart = true
        defer { isUpdatingCart = false }

        let existingItems = self.items.filter { $0.name == movie.name }
        let currentAmount = existingItems.reduce(0) { $0 + $1.orderAmount }
        let newTotalAmount = currentAmount + amountChange
        
        do {
            // Önce sunucudaki bu filme ait tüm eski kayıtları temizle
            for item in existingItems {
                if item.cartId > 0 { // Geçici olarak eklenmiş (cartId=0) satırları silmeye çalışma
                    try await service.deleteMovieFromCart(cartId: item.cartId, userName: item.userName)
                }
            }
            
            // Yeni adet 0'dan büyükse, yeni toplam adetle tek bir kayıt olarak ekle
            if newTotalAmount > 0 {
                try await service.addMovieToCart(movie: movie, orderAmount: newTotalAmount)
            }
            
            // Son olarak, lokal veriyi sunucuyla senkronize etmek için sepeti yeniden çek
            self.items = try await service.fetchCart()
            
        } catch {
            self.errorMessage = "Sepet güncellenemedi: \(error.localizedDescription)"
            // Hata durumunda tutarlılığı sağlamak için sepeti yeniden yükle
            self.items = (try? await service.fetchCart()) ?? items
        }
    }

    func addToCart(movie: Movies, orderAmount: Int) async {
        await updateCart(for: movie, amountChange: orderAmount)
        showToast(message: "\(orderAmount)  \(movie.name) added to cart")
    }

    func addToCart(movie: Movies) async {
        await addToCart(movie: movie, orderAmount: 1)
    }

    func increaseQuantity(for item: MovieCart) async {
        let movieModel = Movies(from: item)
        await updateCart(for: movieModel, amountChange: 1)
    }

    func decreaseQuantity(for item: MovieCart) async {
        let movieModel = Movies(from: item)
        await updateCart(for: movieModel, amountChange: -1)
    }

    func delete(cartItem: MovieCart) async {
        let originalItems = self.items
        items.removeAll { $0.cartId == cartItem.cartId }
        
        do {
            try await service.deleteMovieFromCart(cartId: cartItem.cartId, userName: cartItem.userName)
        } catch {
            self.errorMessage = error.localizedDescription
            self.items = originalItems
        }
    }
    
    private func showToast(message: String) {
        toastMessage = message
        withAnimation(.spring()) {
            showSuccessToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            withAnimation(.easeOut) {
                self?.showSuccessToast = false
            }
        }
    }
}

extension Movies {
    init(from cartItem: MovieCart) {
        self.init(id: 0,
                  name: cartItem.name,
                  image: cartItem.image,
                  price: cartItem.price,
                  category: cartItem.category,
                  rating: cartItem.rating,
                  year: cartItem.year,
                  director: cartItem.director,
                  description: cartItem.description)
    }
}
