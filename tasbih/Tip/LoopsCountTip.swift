//
//  LoopsCountTip.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.03.2025.
//

import SwiftUI
import TipKit

struct LoopsCountTip: Tip {
    
    var title: Text {
        Text(String.text.tip.loopsCount.title)
    }
    
    var message: Text? {
        Text(String.text.tip.loopsCount.message)
    }
    
    static let appOpenedCount = Event(id: "appOpenedCount")
    
    var rules: [Rule] = [
        #Rule(Self.appOpenedCount) { $0.donations.count > 8 }
    ]
    
    var options: [Option] {
        [
            MaxDisplayCount(1)
        ]
    }
}
