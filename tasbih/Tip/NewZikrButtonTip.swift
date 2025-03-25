//
//  NewZikrButtonTip.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.03.2025.
//

import SwiftUI
import TipKit

struct NewZikrButtonTip: Tip {
    
    var title: Text {
        Text(String.text.tip.newZikrButton.title)
    }
    
    var message: Text? {
        Text(String.text.tip.newZikrButton.message)
    }
    
    var image: Image? {
        Image.app.tip.newZikrButton
    }
    
    static let zikrsOpenedCount = Event(id: "zikrsOpenedCount")
    
    var rules: [Rule] = [
        #Rule(Self.zikrsOpenedCount) { $0.donations.count > 1 }
    ]
    
    var options: [Option] {
        [
            MaxDisplayCount(1)
        ]
    }
}
