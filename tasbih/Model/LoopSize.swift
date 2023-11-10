//
//  LoopSize.swift
//  tasbih
//
//  Created by Khalil Sabirov on 11.11.2023.
//

import Foundation

enum LoopSize: Int, CaseIterable {
    case s = 33
    case m = 100
    case l = 1000

    var title: String {
        "Mode \(rawValue)"
    }

    var selectedIconName: String {
        "checkmark"
    }
}
