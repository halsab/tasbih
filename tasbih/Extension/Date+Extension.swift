//
//  Date+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 20.02.2025.
//

import Foundation

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isInThisWeek: Bool {
        Calendar.current.isDate(self, equalTo: .now, toGranularity: .weekOfYear)
    }
    
    var isInThisMonth: Bool {
        Calendar.current.isDate(self, equalTo: .now, toGranularity: .month)
    }
    
    var isInThisYear: Bool {
        Calendar.current.isDate(self, equalTo: .now, toGranularity: .year)
    }
    
    var dayNumber: String {
        formatted(Date.FormatStyle().day(.defaultDigits))
    }
    
    var weekNumber: String {
        formatted(Date.FormatStyle().week(.defaultDigits))
    }
    
    var monthName: String {
        formatted(Date.FormatStyle().month(.wide))
    }
    
    var yearNumber: String {
        formatted(Date.FormatStyle().year(.defaultDigits))
    }
}
