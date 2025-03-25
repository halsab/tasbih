//
//  UndoTip.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.03.2025.
//

import SwiftUI
import TipKit

struct UndoTip: Tip {
    
    var title: Text {
        Text(String.text.tip.undo.title)
    }
    
    var message: Text? {
        Text(String.text.tip.undo.message)
    }
    
    static let appOpenedCount = Event(id: "appOpenedCount")
    
    var rules: [Rule] = [
        #Rule(Self.appOpenedCount) { $0.donations.count > 4 }
    ]
    
    var options: [Option] {
        [
            MaxDisplayCount(1)
        ]
    }
}
