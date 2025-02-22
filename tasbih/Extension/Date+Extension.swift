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
}
