//
//  MovieCart.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation

struct CartResponse: Codable {
    let movie_cart: [MovieCart]
}

struct MovieCart: Codable, Identifiable {
    let cartId: Int
    let name: String
    let image: String
    let price: Int
    let category: String
    let rating: Double
    let year: Int
    let director: String
    let description: String
    var orderAmount: Int
    let userName: String
    var id: Int { cartId }
}


