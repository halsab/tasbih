//
//  ResetPeriod.swift
//  tasbih
//
//  Created by Khalil Sabirov on 22.02.2025.
//

import Foundation

enum ResetPeriod: Codable, CaseIterable {
    case day
    case week
    case month
    case year
    case infinity
    
    var name: String {
        switch self {
        case .day: "День"
        case .week: "Неделя"
        case .month: "Месяц"
        case .year: "Год"
        case .infinity: "Бесконечно"
        }
    }
}
