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
                    
                    // MARK: Color scheme
                    
                    VStack {
                        HStack {
                            Text("Color scheme")
                                .font(.headline)
                            Spacer()
                        }
                        Picker("Color scheme", selection: $appManager.colorScheme) {
                            ForEach(AppColorScheme.allCases) {
                                Text($0.name)
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                    }
                    
                    // MARK: App tint color
                    
                    Divider()
                    VStack {
                        HStack {
                            Text("App tint color")
                                .font(.headline)
                            Spacer()
                        }
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
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(appManager.tint.color, lineWidth: 2)
                        )
                    }
                    
                    // MARK: Loop sizes
                    
                    Divider()
                    VStack {
                        HStack {
                            Text("Loop sizes")
                                .font(.headline)
                            Spacer()
                        }
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
                    
                    // MARK: Count goals
                    
                    Divider()
                    VStack {
                        HStack {
                            Text("Count goals")
                                .font(.headline)
                            Spacer()
                        }
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
                    
                    // MARK: Hard reset all
                    
                    Divider()
                    Button {
                        showAlert = true
                    } label: {
                        Text("Hard reset all")
                            .modifier(TintButtonTextStyle(tint: appManager.tint.color))
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
            .onTapGesture {
                isFocused = false
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
