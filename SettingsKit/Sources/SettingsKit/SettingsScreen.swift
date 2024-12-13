//
//  SettingsScreen.swift
//  SettingsKit
//
//  Created by Khalil Sabirov on 10.11.2024.
//

import SwiftUI
import HelperKit
import AppUIKit

enum AppScheme: String, CaseIterable {
    case dark = "Dark"
    case light = "Light"
    case device = "Device"
}

public struct SettingsScreen: View {
    
    @AppStorage(.storageKey.common.appScheme) private var appScheme: AppScheme = .device
    
    private let colorSchemeUtility = ColorSchemeUtility()
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                Section(header: Text("App scheme")) {
                    Picker("Select app scheme", selection: $appScheme) {
                        ForEach(AppScheme.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Settings")
            .onChange(of: appScheme) { _, _ in
                colorSchemeUtility.overrideDisplayMode()
            }
        }
    }
}

#Preview {
    SettingsScreen()
}
