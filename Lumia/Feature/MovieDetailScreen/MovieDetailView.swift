//
//  MovieDetailView.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//
import SwiftUI

struct MovieDetailView: View {
    let movie: Movies
    @EnvironmentObject var cartVM: CartViewModel
    @State private var quantity: Int = 1
    var body: some View {
        // Ana Konteyner
        VStack(alignment: .leading, spacing: 0) {

            AsyncImage(url: URL(string: Endpoints.getMovieImage(named: movie.image))) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .overlay(ProgressView())
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .clipped()
            // Fiyat etiketi (poster üstü)
            .overlay(alignment: .topTrailing) {
                Text(Formatting.currency(movie.price))
                    .font(.subheadline).bold()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.theme.accent.opacity(0.9))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(12)
            }
        
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Directed by \(movie.director)")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.7))
                
                HStack(spacing: 12) {
                    InfoPill(text: String(movie.year))
                    InfoPill(text: movie.category)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", movie.rating))
                            .fontWeight(.medium)
                    }
                }
                .foregroundColor(.white)
                .padding(.top, 8)
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 8)

           
            ScrollView(.vertical) {
                Text(movie.description)
                    .padding(.horizontal)
                    .foregroundColor(.white.opacity(0.9))
                    
            }

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Count")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Stepper(value: $quantity, in: 1...20) {
                        Text("\(quantity)")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                HStack {
                    Text("Total")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                    Spacer()
                    Text(Formatting.currency(movie.price * quantity))
                        .font(.title3).bold()
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            .background(Color.theme.background)
            .cornerRadius(12)
            .padding([.horizontal, .bottom])
            
          
        }
        .withLogoTitle()
        .background(Color.theme.backgroundAlt)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    HapticsManager.shared.notify(.success)
                    Task { await cartVM.addToCart(movie: movie, orderAmount: quantity) }
                }) {
                    Label("Add to cart", systemImage: "cart.badge.plus")
                }
            }
        }
    }
}

    

#Preview {
    let sampleMovie = Movies(id: 10,
                             name: "Dune",
                             image: "dune.png",
                             price: 19,
                             category: "Science Fiction",
                             rating: 8.0,
                             year: 2021,
                             director: "Denis Villeneuve",
                             description: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence—a commodity capable of unlocking humanity's greatest potential—only those who can conquer their fear will survive. This is a very long description to test the scrolling functionality and ensure that only this text moves while the rest of the UI, including the poster, title, and the bottom button, remains completely static.")
    
    NavigationView {
        MovieDetailView(movie: sampleMovie)
            .environmentObject(CartViewModel())
    }
}
