//
//  LoopSize.swift
//  tasbih
//
//  Created by Khalil Sabirov on 11.11.2023.
//

import SwiftUI

enum LoopSize: UInt, CaseIterable, Codable {
    case _7 = 7
    case _10 = 10
    case _33 = 33
    case _40 = 40
    case _100 = 100
    case _1000 = 1000
    case inf = 999999

    var title: String {
        switch self {
        case .inf:
            "Mode " + .text.icon.infinity
        default:
            "Mode \(rawValue)"
        }
    }

    var shortTitle: String {
        switch self {
        case .inf:
            .text.icon.infinity
        default:
            "\(rawValue)"
        }
    }

    var selectedIcon: Image {
        Image.app.icon.selected
    }
}
