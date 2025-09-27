//
//  LottieView.swift
//  Lumia
//
//  Created by Esma Nur Arslan on 18.09.2025.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
   var fileName: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        let view = UIView(frame: .zero)
  
        let config = LottieConfiguration(renderingEngine: .mainThread)
        let animationView = LottieAnimationView(configuration: config)
        let animation = LottieAnimation.named(fileName)
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}
