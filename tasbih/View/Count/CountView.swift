//
//  CountView.swift
//  muslimTools
//
//  Created by halsab on 10.11.2022.
//

import SwiftUI

struct CountView: View {
    
    @EnvironmentObject var appManager: AppManager
    @EnvironmentObject var countManager: CountManager
    
    @State private var showCalendar = false
    @State private var showSettings = false
    @State private var showHardResetAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bg
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Loops: ") + Text("\(countManager.loops)")
                            .font(.system(.footnote, design: .monospaced))
                        Spacer()
                        Text("Total: ") + Text("\(countManager.total)")
                            .font(.system(.footnote, design: .monospaced))
                    }
                    .foregroundColor(.secondary)
                    .font(.system(.footnote, design: .rounded))
                    
                    Button {
                        countManager.increment()
                    } label: {
                        Text("\(countManager.value)")
                            .modifier(LargeCountButtonTextStyle(tint: appManager.tint.color))
                    }
                    
                    HStack {
                        Text("Reset")
                            .modifier(TintButtonTextStyle(tint: appManager.tint.color))
                            .onTapGesture {
                                countManager.reset()
                            }
                            .onLongPressGesture(minimumDuration: 0.3) {
                                let impact = UIImpactFeedbackGenerator(style: .medium)
                                impact.impactOccurred()
                                showHardResetAlert = true
                            }
                        
                        Button {
                            countManager.decrement()
                        } label: {
                            Text("Undo")
                                .modifier(TintButtonTextStyle(tint: appManager.tint.color))
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showCalendar.toggle()
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Picker("Count Type", selection: $countManager.selectedCountId) {
                        ForEach(countManager.counts, id: \.id) {
                            Text("\($0.loopSize)").tag($0.id)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
            }
            .sheet(isPresented: $showCalendar) {
                CalendarView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .alert("Do you want to hard reset current count?", isPresented: $showHardResetAlert) {
                Button("Yes", role: .destructive) {
                    countManager.hardReset()
                }
                Button("No", role: .cancel) {}
            }
        }
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView()
            .environmentObject(AppManager())
            .environmentObject(CountManager())
    }
}
