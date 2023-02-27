//
//  CountDay.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import SwiftUI

struct CountDay: Identifiable, Codable {
    let id = UUID()
    let date: Date
    var count: Int
    var goal: Int
    
    var dateString: String {
        date.asString(format: .type1)
    }
    
    var isCurrentMonthday: Bool {
        date.isCurrentMonthday
    }
    
    var color: Color {
        let middle = 0.5
        let high = 1.0
        switch percent {
        case let x where x > 0 && x < middle:
            return .systemRed
        case let x where x >= middle && x < high:
            return .systemYellow
        case let x where x >= high:
            return .systemGreen
        default:
            return .gray2
        }
    }
    
    private var percent: Double {
        let doubleCountGoal = Double(goal)
        let result = Double(count) / doubleCountGoal
        switch result {
        case let x where x > 0 && x <= 1:
            return x
        case let x where x > 1:
            return 1
        default:
            return 0
        }
    }
}
