//
//  ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI
import SwiftData
import Module

struct ContentView: View {
    private let container: ModelContainer
    
    var body: some View {
        CountScreen(modelContext: container.mainContext)
            .statusBar(hidden: true)
    }
    
    init() {
        do {
            container = try ModelContainer(for: ZikrModel.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
}

#Preview {
    ContentView()
}
