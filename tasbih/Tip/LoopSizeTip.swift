//
//  LoopSizeTip.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.03.2025.
//

import SwiftUI
import TipKit

struct LoopSizeTip: Tip {
    
    var title: Text {
        Text(String.text.tip.loopSize.title)
    }
    
    var message: Text? {
        Text(String.text.tip.loopSize.message)
    }
    
    var image: Image? {
        Image.app.tip.loopSize
    }

    static let appOpenedCount = Event(id: "appOpenedCount")
    
    var rules: [Rule] = [
        #Rule(Self.appOpenedCount) { $0.donations.count > 2 }
    ]
    
    var options: [Option] {
        [
            MaxDisplayCount(1)
        ]
    }
}
