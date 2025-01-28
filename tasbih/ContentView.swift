//
//  ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI
import ZikrKit

struct ContentView: View {
    var body: some View {
        CountScreen()
            .modelContainer(for: ZikrModel.self)
            .statusBar(hidden: true)
    }
}

#Preview {
    ContentView()
}
