//
//  IncrementZikrTip.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.03.2025.
//

import SwiftUI
import TipKit

struct IncrementZikrTip: Tip {
    
    var title: Text {
        Text(String.text.tip.incrementZikr.title)
    }
    
    var message: Text? {
        Text(String.text.tip.incrementZikr.message)
    }
    
    static let zikrsOpenedCount = Event(id: "zikrsOpenedCount")
    
    var rules: [Rule] = [
        #Rule(Self.zikrsOpenedCount) { $0.donations.count > 0 }
    ]
    
    var options: [Option] {
        [
            MaxDisplayCount(1)
        ]
    }
}
