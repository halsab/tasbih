//
//  CountModel.swift
//  tasbih
//
//  Created by Khalil Sabirov on 02.07.2024.
//

import Foundation
import SwiftData

@Model
final class CountModel {
    @Attribute(.unique) let id: UUID
    let name: String
    var totalCount: Int
    var loopSize: LoopSize
    var date: Date

    var count: Int {
        totalCount % loopSize.rawValue
    }
    var loopsCount: Int {
        totalCount / loopSize.rawValue
    }

    init(
        name: String,
        loopSize: LoopSize
    ) {
        self.id = UUID()
        self.name = name
        self.totalCount = 0
        self.loopSize = loopSize
        self.date = .now
    }
}


