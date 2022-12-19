//
//  CountDay.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import SwiftUI

struct CountDay: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
    
    var dateString: String {
        date.asString(format: .type1)
    }
    
    var isCurrentMonthday: Bool {
        date.isCurrentMonthday
    }
    
    func percent(for countGoal: Int) -> Double {
        let doubleCountGoal = Double(countGoal)
        let result = Double(count) / doubleCountGoal
        switch result {
        case let x where x > 0 && x <= 0.08:
            return 0.08
        case let x where x > 0.08 && x <= 1:
            return x
        case let x where x > 1:
            return 1
        default:
            return 0
        }
    }
    
    func color(for countLimit: Int) -> Color {
        let percent = percent(for: countLimit)
        let middle = 0.25
        let high = 0.8//1.0
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
}
