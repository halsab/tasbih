//
//  ZikrModel.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import Foundation
import SwiftData

@Model
final public class ZikrModel: Identifiable {
    @Attribute(.unique)
    public var id: UUID
    @Attribute(.unique)
    var name: String
    var count: Int
    var loopSize: LoopSize
    var date: Date
    
    @Transient
    var currentLoopCount: Int {
        count % loopSize.rawValue
    }
    @Transient
    var loopsCount: Int {
        count / loopSize.rawValue
    }
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.count = 0
        self.loopSize = .s
        self.date = .now
    }
}
