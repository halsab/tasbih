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
    
    static var user: () -> Date = {
        Date()
    }
    
    var isCurrentMonthday: Bool {
        let calendar = Calendar.user()
        let currentMonth = calendar.component(.month, from: Date.user())
        let checkMonth = calendar.component(.month, from: self)
        return currentMonth == checkMonth
    }

    func asString(format: DateFormat) -> String {
        let formatter = DateFormatter.user()
        formatter.locale = .init(identifier: "en_EN")
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }    
}
