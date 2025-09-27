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
                }.withLogoTitle()
            }
            .background(Color.theme.backgroundAlt)
            
        }
        
    }
}
#Preview {
    HomeView().environmentObject(CartViewModel())
}
