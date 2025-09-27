//
//  Endpoints.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation

struct Endpoints {
    static let baseUrl = "http://kasimadalan.pe.hu/movies/"
    static let allMovies = "\(baseUrl)getAllMovies.php"
    static let insertMovie = "\(baseUrl)insertMovie.php"
    static let getMovieCart = "\(baseUrl)getMovieCart.php"
    static let deleteMovie = "\(baseUrl)deleteMovie.php"
    private static let baseImageUrl = "\(baseUrl)images/"
    
    static func getMovieImage(named imageName: String) -> String {
            return "\(baseImageUrl)\(imageName)"
        }
}
