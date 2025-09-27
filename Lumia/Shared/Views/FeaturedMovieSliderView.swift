//
//  FeaturedMovieSliderView.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 18.09.2025.
//

import SwiftUI

// MARK: - Featured Movie Slider (Ana Bileşen)

struct FeaturedMovieSliderView: View {
    let movies: [Movies]
    let onAddToCart: (Movies) -> Void
    
    var body: some View {
        if !movies.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(movies) { movie in
                        SlideCardView(movie: movie, onAddToCart: {
                            onAddToCart(movie)
                        })
                        .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 450)
        }
    }
}


struct SlideCardView: View {
    let movie: Movies
    let onAddToCart: () -> Void
    
    var body: some View {
       
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            ZStack {
                AsyncImage(url: URL(string: Endpoints.getMovieImage(named: movie.image))) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.3))
                        .overlay(ProgressView())
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Text(movie.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 20)
                        Spacer()
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.clear, .theme.background.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
            }
            .shadow(color: .theme.logo.opacity(0.8), radius: 10, y: 1)
        }
        .buttonStyle(.plain)
    }
}

#Preview("Featured Movie Slider") {
    let sampleMovies = [
        Movies(id: 1, name: "Dune", image: "dune.png", price: 20, category: "Sci-Fi", rating: 8.5, year: 2021, director: "DV", description: "..."),
        Movies(id: 2, name: "Joker", image: "joker.png", price: 22, category: "Drama", rating: 8.8, year: 2019, director: "TP", description: "...")
    ]
    
    NavigationView {
        FeaturedMovieSliderView(movies: sampleMovies, onAddToCart: { movie in
            print("\(movie.name) sepete eklendi.")
        })
        .environmentObject(CartViewModel())
    }
}

#Preview("Single Slide Card") {
    let sampleMovie = Movies(id: 10, name: "Dune", image: "dune.png", price: 19, category: "Science Fiction", rating: 8.0, year: 2021, director: "Denis Villeneuve", description: "Lorem ipsum...")

    NavigationView {
        ZStack {
            Color.black.ignoresSafeArea()
            SlideCardView(movie: sampleMovie, onAddToCart: {
                print("Tek karttan sepete eklendi.")
            })
            .padding()
        }
    }
    .environmentObject(CartViewModel())
}
