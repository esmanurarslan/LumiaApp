//
//  Haptics.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 20.09.2025.
//

import UIKit

enum HapticFeedback {
    case success
    case warning
    case error
    case light
    case medium
    case heavy
}

final class HapticsManager {
    static let shared = HapticsManager()
    private init() {}
    
    func notify(_ type: HapticFeedback) {
        switch type {
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
    }
}
