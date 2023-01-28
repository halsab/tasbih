//
//  CountType.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import Foundation

enum CountType: Hashable, Identifiable {
    case first
    case second
    case third
    case custom(Int)
    
    var id: Self { self }
    
    var loopSize: Int {
        switch self {
        case .first:
            return 33
        case .second:
            return 100
        case .third:
            return 1000
        case .custom(let value):
            return value
        }
    }
    
    var name: String {
        String(loopSize)
    }
    
    var total: Int {
        UserDefaults.standard.integer(forKey: self.name)
    }
    
    func save(_ value: Int) {
        UserDefaults.standard.set(value, forKey: self.name)
    }
}
