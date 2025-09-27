//
//  UserManager.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 17.09.2025.
//

import Foundation
import Combine

// Uygulamanın o anki "giriş yapmış" kullanıcısını yöneten sınıf.

class UserManager: ObservableObject {
    
    static let shared = UserManager()
    @Published var currentUser: User?
    private init() {
        self.currentUser = User.defaultUser
    }
}
