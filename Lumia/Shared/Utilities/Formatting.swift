//
//  Formatting.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 20.09.2025.
//

import Foundation

enum Formatting {
    static func currency(_ amount: Int, locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: amount)) ?? "$\(amount)"
    }
}
