//
//  CountView.swift
//  muslimTools
//
//  Created by halsab on 10.11.2022.
//

import SwiftUI

struct CountView: View {
    
    @EnvironmentObject var am: AppManager
    @EnvironmentObject var cm: CountManager
    
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
                        Text("Loops: \(cm.loops)")
                        Spacer()
                        Text("Total: \(cm.total)")
                    }
                    .foregroundColor(.secondary)
                    
                    Button {
                        cm.increment()
                    } label: {
                        Text("\(cm.value)")
                            .modifier(LargeCountButtonTextStyle(tint: am.tint.color))
                    }
                    
                    HStack {
                        Text("Reset")
                            .modifier(TintButtonTextStyle(tint: am.tint.color))
                            .onTapGesture {
                                cm.reset()
                            }
                            .onLongPressGesture(minimumDuration: 0.3) {
                                let impact = UIImpactFeedbackGenerator(style: .medium)
                                impact.impactOccurred()
                                showHardResetAlert = true
                            }
                        
                        Button {
                            cm.decrement()
                        } label: {
                            Text("Undo")
                                .modifier(TintButtonTextStyle(tint: am.tint.color))
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
                    Picker("Count Type", selection: $cm.selectedCountId) {
                        ForEach(cm.counts, id: \.id) {
                            Text("\($0.loopSize)").tag($0.id)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
            }
            .sheet(isPresented: $showCalendar) {
                CalendarView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .alert("Do you want to hard reset current count?", isPresented: $showHardResetAlert) {
                Button("Yes", role: .destructive) {
                    cm.hardReset()
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
