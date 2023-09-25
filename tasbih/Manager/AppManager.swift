//
//  AppManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine

final class AppManager: ObservableObject {
    
    @Published var tint: TintColor = .monochrome
    
    private let UD = UserDefaults.standard
    private var anyCancellables = Set<AnyCancellable>()
    
    init() {
        tint = storedTint
        $tint
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] tint in
                storedTint = tint
            }
            .store(in: &anyCancellables)
    }
    
    
}

// MARK: - User Defaults

private extension AppManager {
    enum UDKey: String {
        case tint
    }
    
    var storedTint: TintColor {
        get {
            if let data = UD.data(forKey: UDKey.tint.rawValue),
               let tintColor = try? JSONDecoder().decode(TintColor.self, from: data) {
                return tintColor
            } else {
                return TintColor.allCases.first!
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UD.set(data, forKey: UDKey.tint.rawValue)
            }
        }
    }
}
