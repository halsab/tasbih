//
//  ZikrModel.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import Foundation
import SwiftData

@Model
final class ZikrModel {
    @Attribute(.unique)
    var name: String
    var count: Int
    var loopSize: LoopSize
    var date: Date
    
    init(name: String, count: Int = 0, loopSize: LoopSize = .m, date: Date = .now) {
        self.name = name
        self.count = count
        self.loopSize = loopSize
        self.date = date
    }
}
