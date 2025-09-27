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

    // Aynı anda sadece bir sepet güncelleme işlemi yapıldığından emin olmak için
    private var isUpdatingCart = false

    private let service: MovieService

    init(service: MovieService = MovieService()) {
        self.service = service
    }

    var totalPrice: Int {
        items.reduce(0) { $0 + ($1.price * $1.orderAmount) }
    }


    func loadCart() async {
        if isLoading { return }
        isLoading = true
        errorMessage = nil
        do {
            self.items = try await service.fetchCart()
        } catch {
            self.items = []
        }
        isLoading = false
    }


    private func updateCart(for movie: Movies, amountChange: Int) async {

        guard !isUpdatingCart else { return }
        
        isUpdatingCart = true

        defer { isUpdatingCart = false }

        let existingItems = self.items.filter { $0.name == movie.name }
        let currentAmount = existingItems.reduce(0) { $0 + $1.orderAmount }
        let newTotalAmount = currentAmount + amountChange
        
        do {
      
            for item in existingItems {
              
                if item.cartId > 0 {
                    try await service.deleteMovieFromCart(cartId: item.cartId, userName: item.userName)
                }
            }
            
            if newTotalAmount > 0 {
                try await service.addMovieToCart(movie: movie, orderAmount: newTotalAmount)
            }
            
         
            self.items = try await service.fetchCart()
            
        } catch {
            
            self.errorMessage = "Sepet güncellenemedi: \(error.localizedDescription)"
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
