//
//  ColorSchemeUtility.swift
//  SettingsKit
//
//  Created by Khalil Sabirov on 10.11.2024.
//

import SwiftUI

@MainActor
final class ColorSchemeUtility {
    
    @AppStorage(.storageKey.common.appScheme) private var appScheme: AppScheme = .device
    
    private var userInterfaceStyle: ColorScheme?
    
    func overrideDisplayMode() {
        let userInterfaceStyle: UIUserInterfaceStyle = switch appScheme {
        case .dark: .dark
        case .light: .light
        case .device: .unspecified
        }
        
        if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow {
            window.overrideUserInterfaceStyle = userInterfaceStyle
        }
    }
}
