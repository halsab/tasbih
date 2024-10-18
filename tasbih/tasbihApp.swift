//
//  tasbihApp.swift
//  tasbih
//
//  Created by Khalil Sabirov on 19.12.2022.
//

import SwiftUI

@main
struct tasbihApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.dark)
                .statusBar(hidden: true)
        }
    }
}
