//
//  ResetPeriod.swift
//  tasbih
//
//  Created by Khalil Sabirov on 22.02.2025.
//

import Foundation

enum ResetPeriod: String, Codable, CaseIterable {
    case day
    case week
    case month
    case year
    case infinity
}
