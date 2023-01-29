//
//  SettingsView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var am: AppManager
    @EnvironmentObject var cm: CountManager
    
    @State private var showAlert = false
    
    var body: some View {
        Form {
            Section("Color scheme") {
                Picker("Color scheme", selection: $am.colorScheme) {
                    ForEach(AppColorScheme.allCases) {
                        Text($0.name)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }
            Section("App tint color") {
                Picker("App tint color", selection: $am.tint) {
                    ForEach(TintColor.allCases) {
                        Text($0.name)
                            .foregroundColor(.bg)
                            .frame(maxWidth: .infinity)
                            .background($0.color)
                            .cornerRadius(8)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 100)
                .clipped()
                .labelsHidden()
            }
            Button {
                showAlert = true
            } label: {
                Text("Hard reset all")
                    .padding(4)
                    .foregroundColor(.systemRed)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderless)
        }
        .alert("Hard reset all counts?", isPresented: $showAlert) {
            Button("Yes", role: .destructive) {
                cm.hardResetAll()
            }
            Button("Cancel", role: .cancel) { }
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
