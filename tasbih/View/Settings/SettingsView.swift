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
    
    var body: some View {
        Form {
            Section("Color scheme") {
                Picker("Color scheme", selection: $appManager.colorScheme) {
                    ForEach(AppColorScheme.allCases) {
                        Text($0.name)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }
            Section("App tint color") {
                Picker("App tint color", selection: $appManager.tint) {
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
            Section("Loop sizes") {
                ForEach(countManager.counts) { count in
                    HStack(spacing: 16) {
                        Image(systemName: countManager.selectedCountId == count.id ? "circle.fill" : "circle")
                            .foregroundColor(appManager.tint.color)
                        TextField("Loop", text: Binding(
                            get: { String(count.loopSize) },
                            set: {
                                guard let loopSize = Int($0) else { return }
                                countManager.setLoopSize(loopSize, for: count.id)
                            }
                        ))
                        .focused($isFocused)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    }
                }
            }
            .listRowSeparator(.hidden)
            Section("Count goals") {
                ForEach(countManager.counts) { count in
                    HStack(spacing: 16) {
                        Image(systemName: countManager.selectedCountId == count.id ? "circle.fill" : "circle")
                            .foregroundColor(appManager.tint.color)
                        Text("Loop \(count.loopSize)")
                        TextField("Goal", text: Binding(
                            get: { String(count.goal) },
                            set: {
                                guard let goal = Int($0) else { return }
                                countManager.setGoal(goal, for: count.id)
                            }
                        ))
                        .focused($isFocused)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    }
                }
            }
            .listRowSeparator(.hidden)
            Section {
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
        }
        .alert("Hard reset all counts?", isPresented: $showAlert) {
            Button("Yes", role: .destructive) {
                countManager.hardResetAll()
            }
            Button("Cancel", role: .cancel) { }
        }
        .onTapGesture {
            isFocused = false
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
