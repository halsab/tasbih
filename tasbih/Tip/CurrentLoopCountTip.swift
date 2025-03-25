//
//  CurrentLoopCountTip.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.03.2025.
//

import SwiftUI
import TipKit

struct CurrentLoopCountTip: Tip {
    
    var title: Text {
        Text(String.text.tip.currentLoopCount.title)
    }
    
    var message: Text? {
        Text(String.text.tip.currentLoopCount.message)
    }
    
    static let appOpenedCount = Event(id: "appOpenedCount")
    
    var rules: [Rule] = [
        #Rule(Self.appOpenedCount) { $0.donations.count > 7 }
    ]
    
    var options: [Option] {
        [
            MaxDisplayCount(1)
        ]
    }
}
