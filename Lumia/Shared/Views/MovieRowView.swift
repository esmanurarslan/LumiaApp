//
//  MovieRowView.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import SwiftUI

struct MovieRowView: View {
    var onAddToCart: (Movies) -> Void
    let row: MovieRow
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(row.title)
                    .font(.title2.bold())
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 24) {
                        ForEach(row.movies) { movie in
                            MovieCardView(movie: movie, onAddToCart: {
                                onAddToCart(movie)
                            })
                        }
                    }
                    .padding(.horizontal)
                    
                    
                }
            }
            .padding(.vertical, 8)
            
        }
    }


    #Preview {
        // Örnek bir film listesi
        let sampleMovies = [
            Movies(id: 1, name: "Dune", image: "dune.png", price: 20, category: "Sci-Fi", rating: 8.5, year: 2021, director: "DV", description: "..."),
            Movies(id: 2, name: "Joker", image: "joker.png", price: 22, category: "Drama", rating: 8.8, year: 2019, director: "TP", description: "...")
        ]
        
        let sampleRow = MovieRow(title: "Öne Çıkanlar", movies: sampleMovies)
        
        MovieRowView(onAddToCart: { movie in
            print("\(movie.name) önizlemede sepete eklendi.")
        }, row: sampleRow)
    }
