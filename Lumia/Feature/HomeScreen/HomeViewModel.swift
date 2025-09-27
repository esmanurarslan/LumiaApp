//
//  HomeViewModel.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation

struct MovieRow {
    let title: String
    let movies: [Movies]
}

@MainActor
class HomeViewModel: ObservableObject{
    
    @Published var movieRows: [MovieRow] = []
    @Published var isLoading: Bool = false
    @Published var allMovies: [Movies] = []
    
    // Arama metni
    @Published var searchText: String = ""
    
    private let movieService = MovieService()
    
    init() {
        fetchAllMovies()
    }
    
    func fetchAllMovies() {
        self.isLoading = true
        print("✅ fetchAllMovies fonksiyonu çalıştı. Yükleme başlıyor...")
        
        Task {
            do {
                let fetchedMovies = try await movieService.fetchAllMovies()
                
                print("✅ Başarıyla \(fetchedMovies.count) adet film çekildi.")
              
                if let firstMovie = fetchedMovies.first {
                    print("➡️ İlk filmin verisi: \(firstMovie)")
                }
                
                self.allMovies = fetchedMovies
                self.setupMovieRows()
                
            } catch {
                print("❌ HATA: Filmler çekilirken bir hata oluştu!")
                print("Error Details: \(error)")
                print("Localized Description: \(error.localizedDescription)")
            }
            
            self.isLoading = false
            print("🛑 Yükleme tamamlandı. isLoading = false")
        }
    }
    
    private func setupMovieRows() {
        var rows: [MovieRow] = []
        
        let movies = self.allMovies
        if !movies.isEmpty {
            rows.append(MovieRow(title: "All Movies", movies: movies))
        }
        
        // 1. Özel Satır: En Yüksek Puanlılar
        let topRated = Array(movies.sorted { $0.rating > $1.rating }.prefix(10))
        if !topRated.isEmpty {
            rows.append(MovieRow(title: "Top Rated Movies", movies: topRated))
        }
        
        // 2. Özel Satır: Yeni Filmler (Yıla Göre)
        let newReleases = Array(movies.sorted { $0.year > $1.year }.prefix(10))
        if !newReleases.isEmpty {
            rows.append(MovieRow(title: "New Movies", movies: newReleases))
        }
        
        // 3. Kategori Bazlı Satırlar
        let categories = Set(movies.map { $0.category }).sorted()
        for category in categories {
            let categoryMovies = movies.filter { $0.category == category }
            rows.append(MovieRow(title: "\(category) Movies", movies: categoryMovies))
        }
        
        // 4. Yönetmen Bazlı Satırlar (3'ten fazla filmi olanlar)
        let groupedByDirector = Dictionary(grouping: movies, by: { $0.director })
        let prolificDirectors = groupedByDirector
            .filter { $0.value.count > 3 }
            .sorted { lhs, rhs in
                if lhs.value.count == rhs.value.count {
                    return lhs.key < rhs.key
                }
                return lhs.value.count > rhs.value.count
            }
        
        for (director, directorMovies) in prolificDirectors {
            rows.append(MovieRow(title: "\(director) Movies", movies: directorMovies))
        }
        
        self.movieRows = rows
    }
    
    // MARK: - Arama Mantığı
    
    private var trimmedQuery: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // Arama sonuçları (film adı veya yönetmen adına göre, büyük/küçük harf duyarsız)
    var filteredMovies: [Movies] {
        let query = trimmedQuery
        guard !query.isEmpty else { return [] }
        return allMovies.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.director.localizedCaseInsensitiveContains(query)
        }
    }
    
    // Arama önerileri (yönetmenler ve film adları)
    var directorSuggestions: [String] {
        let set = Set(allMovies.map { $0.director })
        return Array(set).sorted()
    }
    
    var titleSuggestions: [String] {
        let set = Set(allMovies.map { $0.name })
        return Array(set).sorted()
    }
}

