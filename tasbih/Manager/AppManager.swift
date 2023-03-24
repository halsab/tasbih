//
//  AppManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine

final class AppManager: ObservableObject {
    
    @Published var tint: TintColor = .brown
    @Published var colorScheme: AppColorScheme = .system
    
    private let UD = UserDefaults.standard
    private var anyCancellables = Set<AnyCancellable>()
    
    init() {
        tint = storedTint
        colorScheme = storedColorScheme
        $tint
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] tint in
                storedTint = tint
            }
            .store(in: &anyCancellables)
        $colorScheme
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] colorScheme in
                storedColorScheme = colorScheme
            }
            .store(in: &anyCancellables)
    }
    
    
}

// MARK: - User Defaults

extension AppManager {
    private enum UDKey: String {
        case tint
        case colorScheme
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
    
    var storedColorScheme: AppColorScheme {
        get {
            if let data = UD.data(forKey: UDKey.colorScheme.rawValue),
               let colorScheme = try? JSONDecoder().decode(AppColorScheme.self, from: data) {
                return colorScheme
            } else {
                return AppColorScheme.allCases.first!
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UD.set(data, forKey: UDKey.colorScheme.rawValue)
            }
        }
    }
}
