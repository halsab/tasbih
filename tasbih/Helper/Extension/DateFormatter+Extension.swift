//
//  DateFormatter+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 04.03.2023.
//

import Foundation

extension DateFormatter {
    static var user: () -> DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en_EN")
        return formatter
    }
}
