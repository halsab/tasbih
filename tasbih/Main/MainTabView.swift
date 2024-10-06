//
//  MainTabView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 06.10.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Zikr", systemImage: "numbers") {
                CountScreen()
            }
            
            Tab("Salah", systemImage: "moon") {
                PrayerTimesView()
            }
            
            Tab("Vird", systemImage: "fireworks") {
                VirdTabScreen()
            }
        }
    }
}

#Preview {
    MainTabView()
}
