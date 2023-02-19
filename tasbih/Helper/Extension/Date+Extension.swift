//
//  Date+Extension.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import SwiftUI

extension Date {
    enum DateFormat: String {
        case type0 = "dd.MM"
        case type1 = "dd"
        case type2 = "LLLL"
    }
    
    static var current: () -> Date = {
        Date()
    }
    
    var isCurrentMonthday: Bool {
        let calendar = Calendar.user
        let currentMonth = calendar.component(.month, from: Date.current())
        let checkMonth = calendar.component(.month, from: self)
        return currentMonth == checkMonth
    }

    func asString(format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }    
}
