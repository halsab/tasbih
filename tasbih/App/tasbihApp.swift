//
//  tasbihApp.swift
//  tasbih
//
//  Created by Khalil Sabirov on 19.12.2022.
//

import SwiftUI
import SwiftData

@main
struct tasbihApp: App {
    @State private var countService: CountService
    
    private let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView(countService: countService)
                .preferredColorScheme(.dark)
        }
    }
    
    init() {
        do {
            container = try ModelContainer(for: ZikrModel.self)
            let countService = CountService(modelContext: container.mainContext)
            _countService = State(initialValue: countService)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
        
    }
}
