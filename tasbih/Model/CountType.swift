//
//  CountType.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import Foundation

enum CountType: CaseIterable, Identifiable {
    case first, second, third
    
    var id: Self { self }
    
    var loopSize: Int {
        switch self {
        case .first:
            return 33
        case .second:
            return 100
        case .third:
            return 1000
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
