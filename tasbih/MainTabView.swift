//
//  MainTabView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 06.10.2024.
//

import SwiftUI
import SalahKit
import ZikrKit
import DuaKit

struct MainTabView: View {
    
    @AppStorage(.storageKey.common.selectedTab) private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: 0) {
                CountScreen()
                    .modelContainer(for: ZikrModel.self)
                    .statusBar(hidden: true)
            } label: {
                Label("Zikr", systemImage: "numbers")
            }
            
            Tab(value: 1) {
                PrayerTimesView()
            } label: {
                Label("Salah", systemImage: "moon")
            }
            
            Tab(value: 2) {
                DuaHomeScreen()
            } label: {
                Label("Dua", systemImage: "book.fill")
            }
        }
        .tint(.app.tint)
    }
}

#Preview {
    MainTabView()
}
