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
import SettingsKit
import HelperKit
import AppUIKit

struct MainTabView: View {
    
    @AppStorage(.storageKey.common.selectedTab) private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CountScreen()
                .modelContainer(for: ZikrModel.self)
                .statusBar(hidden: true)
                .tabItem {
                    Label {
                        Text(String.text.tab.zikr)
                    } icon: {
                        Image.app.tab.zikr
                    }
                }
                .tag(0)
            
            PrayerTimesView()
                .tabItem {
                    Label {
                        Text(String.text.tab.salah)
                    } icon: {
                        Image.app.tab.salah
                    }
                }
                .tag(1)
            
//            Tab(value: 2) {
//                DuaHomeScreen()
//            } label: {
//                Label("Dua", systemImage: "book.fill")
//            }
//            
//            Tab(value: 3) {
//                SettingsScreen()
//            } label: {
//                Label("Settings", systemImage: "gearshape.fill")
//            }
        }
        .tint(.app.highlight)
    }
}

#Preview {
    MainTabView()
}
