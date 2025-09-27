//
//  MovieAPIError.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation
enum MovieAPIError: LocalizedError {
  
    case invalidURL
    case decodingError(Error)
    case serverError(statusCode: Int)
    case unknownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL adresi."
        case .decodingError(let error):
            return "Veri işlenirken bir hata oluştu: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Sunucu hatası. Hata Kodu: \(statusCode)"
        case .unknownError(let error):
            return "Bilinmeyen bir hata oluştu: \(error.localizedDescription)"
        }
    }
}
