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
    let title: String
    let description: String
    
    init(
        image: String,
        title: String,
        description: String
    ) {
        self.image = image
        self.title = title
        self.description = description
    }
}

extension IntroCard {
//    static let cards: [IntroCard] = (0..<8).map {
//        .init(image: "images/intro/\($0)")
//    }
    
    static let cards: [IntroCard] = [
        .init(image: "images/intro/3", title: "\("سبحان")\n\("الله")", description: "Субханаллах\nАллах превыше всего"),
        .init(image: "images/intro/7", title: "\("الحمد")\n\("لله")", description: "Альхамдулильлях\nХвала Аллаху"),
        .init(image: "images/intro/6", title: "\("الله")\n\("أكبر")", description: "Аллаху Акбар\nАллах велик"),
        .init(image: "images/intro/1", title: "\("لا إله")\n\("إلا الله")", description: "Ла Илаха Илла Аллах\nНет бога, кроме Аллаха"),
    ]
}
