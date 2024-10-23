//
//  MainTabView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 06.10.2024.
//

import SwiftUI
import VirdKit
import SalahKit
import ZikrKit

struct MainTabView: View {
    
    @AppStorage(.storageKey.common.selectedTab) private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: 0) {
                CountScreen()
                    .modelContainer(for: ZikrModel.self)
            } label: {
                Label("Zikr", systemImage: "numbers")
            }
            
            Tab(value: 1) {
                PrayerTimesView()
            } label: {
                Label("Salah", systemImage: "moon")
            }
            
            Tab(value: 2) {
                VirdTabScreen()
            } label: {
                Label("Vird", systemImage: "fireworks")
            }
        }
        .tint(.app.tint)
    }
}

#Preview {
    MainTabView()
}
