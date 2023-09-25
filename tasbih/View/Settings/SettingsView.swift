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
    
    @State private var showAlert = false
    @FocusState private var isFocused : Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {

                    // MARK: Hard reset all

                    Button {
                        showAlert = true
                    } label: {
                        Text("Hard reset all")
                    }
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Hard reset all counts?", isPresented: $showAlert) {
                Button("Yes", role: .destructive) {
                    countManager.hardResetAll()
                }
                Button("Cancel", role: .cancel) { }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .tint(appManager.tint.color)
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
