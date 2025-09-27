//
//  Movies.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation

struct MoviesResponse: Codable {
    let movies: [Movies]
}


struct Movies: Codable, Identifiable {
    let id: Int
    let name, image: String
    let price: Int
    let category: String
    let rating: Double
    let year: Int
    let director, description: String
}
