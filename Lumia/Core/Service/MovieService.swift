//
//  MovieService.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation

class MovieService {
    
    private let userManager: UserManager
    
    init(userManager: UserManager = .shared) {
        self.userManager = userManager
    }

    private var currentUserName: String? {
        return userManager.currentUser?.userName
    }
 

    func fetchAllMovies() async throws -> [Movies] {
        
        guard let url = URL(string: Endpoints.allMovies) else {
            throw MovieAPIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            debugPrintResponse(for: URLRequest(url: url), data: data, response: response)
            let response1 = try JSONDecoder().decode(MoviesResponse.self, from: data)
            return response1.movies
        } catch {
            throw MovieAPIError.decodingError(error)
        }
    }

    func fetchCart() async throws -> [MovieCart] {
        guard let userName = currentUserName else {
            throw MovieAPIError.unknownError(NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı bulunamadı."]))
        }
        
        guard let url = URL(string: Endpoints.getMovieCart) else {
            throw MovieAPIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "userName": userName,
            "kullanici_adi": userName
        ]
        request.httpBody = formURLEncodedData(parameters)
        debugPrintRequest(request)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            debugPrintResponse(for: request, data: data, response: response)
            let response2 = try JSONDecoder().decode(CartResponse.self, from: data)
            return response2.movie_cart
        } catch {
            throw MovieAPIError.decodingError(error)
        }
    }


    func addMovieToCart(movie: Movies, orderAmount: Int = 1) async throws {
        guard let userName = currentUserName else { return }
        guard let url = URL(string: Endpoints.insertMovie) else { throw MovieAPIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "name": movie.name,
            "image": movie.image,
            "price": movie.price,
            "category": movie.category,
            "rating": movie.rating,
            "year": movie.year,
            "director": movie.director,
            "description": movie.description,
            "orderAmount": orderAmount,
            "userName": userName,
            "kullanici_adi": userName
        ]
        
        request.httpBody = formURLEncodedData(parameters)
        debugPrintRequest(request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        debugPrintResponse(for: request, data: data, response: response)
    }

    
    func deleteMovieFromCart(cartId: Int, userName: String) async throws {

        guard let url = URL(string: Endpoints.deleteMovie) else { throw MovieAPIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "cartId": cartId,
            "userName": userName
        ]
        
        request.httpBody = formURLEncodedData(parameters)
        debugPrintRequest(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        debugPrintResponse(for: request, data: data, response: response)
    }

    
    private func formURLEncodedData(_ params: [String: Any]) -> Data? {
        var components = URLComponents()
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        return components.percentEncodedQuery?.data(using: .utf8)
    }

    private func debugPrintRequest(_ request: URLRequest) {
        #if DEBUG
        print("\n➡️ Request: \(request.httpMethod ?? "-") \(request.url?.absoluteString ?? "-")")
        if let headers = request.allHTTPHeaderFields { print("Headers: \(headers)") }
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
        #endif
    }

    private func debugPrintResponse(for request: URLRequest, data: Data, response: URLResponse) {
        #if DEBUG
        print("⬅️ Response for: \(request.url?.absoluteString ?? "-")")
        if let http = response as? HTTPURLResponse { print("Status: \(http.statusCode)") }
        if let text = String(data: data, encoding: .utf8) { print("Response Body: \(text)\n") }
        #endif
    }
}
