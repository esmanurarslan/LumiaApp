//
//  HomeView.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var cartVM: CartViewModel
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Arama boşsa mevcut ana sayfa içerikleri
                    if viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        if !viewModel.allMovies.isEmpty {
                            let featuredMovies = Array(viewModel.allMovies)
                            
                            FeaturedMovieSliderView(movies: featuredMovies, onAddToCart: { movie in
                                Task { await cartVM.addToCart(movie: movie) }
                            })
                        }
                        
                        ForEach(viewModel.movieRows, id: \.title) { row in
                            MovieRowView(onAddToCart: { movie in
                                Task { await cartVM.addToCart(movie: movie) }
                            }, row: row)
                        }
                    } else {
                        // Arama doluyken: Arama Sonuçları
                        let results = viewModel.filteredMovies
                        
                        if results.isEmpty {
                            VStack(spacing: 10) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 44))
                                    .foregroundColor(Color.theme.logo)
                                Text("Sonuç bulunamadı")
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            // Mevcut satır görünümünü tekrar kullanarak "Search Results" satırı göster
                            let searchRow = MovieRow(title: "Search Results", movies: results)
                            MovieRowView(onAddToCart: { movie in
                                Task { await cartVM.addToCart(movie: movie) }
                            }, row: searchRow)
                        }
                    }
                }
                .withLogoTitle()
            }
            .background(Color.theme.backgroundAlt)
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search by director or film")
            .disableAutocorrection(true)
            .searchSuggestions {
                let query = viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                if !query.isEmpty {
                    // Yönetmen önerileri
                    ForEach(viewModel.directorSuggestions.filter { $0.localizedCaseInsensitiveContains(query) }.prefix(6), id: \.self) { director in
                        Text("Director: \(director)").searchCompletion(director)
                    }
                    // Film adı önerileri
                    ForEach(viewModel.titleSuggestions.filter { $0.localizedCaseInsensitiveContains(query) }.prefix(6), id: \.self) { title in
                        Text("Movie: \(title)").searchCompletion(title)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView().environmentObject(CartViewModel())
}

