//
//  SettingsView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var appManager: AppManager
    @EnvironmentObject var countManager: CountManager

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Text("Hello world!")
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppManager())
            .environmentObject(CountManager())
    }
}
