//
//  Count.swift
//  tasbih
//
//  Created by Khalil Sabirov on 23.02.2025.
//

import Foundation

struct Count: Codable, Hashable {
    var id = UUID()
    var value: UInt
    let date: Date
}
