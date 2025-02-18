//
//  IntroCard.swift
//  tasbih
//
//  Created by Khalil Sabirov on 16.02.2025.
//

import SwiftUI

struct IntroCard: Identifiable, Hashable {
    let id = UUID().uuidString
    let image: String
}

extension IntroCard {
    static let cards: [IntroCard] = (0..<8).map {
        .init(image: "images/intro/\($0)")
    }
}
