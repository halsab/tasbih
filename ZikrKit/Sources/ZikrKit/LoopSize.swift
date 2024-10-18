//
//  LoopSize.swift
//  tasbih
//
//  Created by Khalil Sabirov on 11.11.2023.
//

import SwiftUI

enum LoopSize: Int, CaseIterable, Codable {
    case xs = 7
    case s = 33
    case m = 100
    case l = 1000
    case infinity = 999999

    var title: String {
        switch self {
        case .infinity:
            "Mode " + .text.icon.infinity
        default:
            "Mode \(rawValue)"
        }
    }

    var shortTitle: String {
        switch self {
        case .infinity:
            .text.icon.infinity
        default:
            "\(rawValue)"
        }
    }

    var selectedIcon: Image {
        Image.app.icon.selected
    }
}
