//
//  PTSettingsScreen.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 09.12.2024.
//

import SwiftUI

struct PTSettingsScreen: View {
    
    @ObservedObject private var vm: PrayerTimesViewModel
    
    init(vm: PrayerTimesViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Calculation method") {
                    Picker("Location", selection: $vm.calculationMethod) {
                        ForEach(PrayerTimesCalculator.Method.allCases) {
                            Text($0.name)
                        }
                    }
                    .frame(height: 120)
                    .pickerStyle(.wheel)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PTSettingsScreen(vm: PrayerTimesViewModel())
}
