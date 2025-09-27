    //
//  User.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let userName: String // API istekleri için kullanılacak olan benzersiz isim
    let email: String
    
    // Uygulama içinde kullanılacak varsayılan kullanıcı
    static var defaultUser = User(
        id: UUID(),
        userName: "esmanurarslan", // Türkçe karakter içermeyen örnek kullanıcı adı (dokümana uygun)
        email: "esmanur@lumia.com"
    )
}
//esmanurarslan
