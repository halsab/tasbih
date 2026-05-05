//
//  tasbihApp.swift
//  tasbih
//
//  Created by Khalil Sabirov on 19.12.2022.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct tasbihApp: App {
    @State private var countService: CountService?
    
    private let container: ModelContainer?
    private let launchErrorMessage: String?
    
    var body: some Scene {
        WindowGroup {
            Group {
                if let countService {
                    ContentView(countService: countService)
                } else {
                    ContentUnavailableView(
                        String.text.error.storageTitle,
                        systemImage: "exclamationmark.triangle",
                        description: Text(launchErrorMessage ?? String.text.error.storageMessage)
                    )
                }
            }
                .preferredColorScheme(.dark)
                .task {
                    try? Tips.configure([
                        .displayFrequency(.daily),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                .task {
                    await LoopSizeTip.appOpenedCount.donate()
                }
        }
    }
    
    init() {
        do {
            let modelContainer = try ModelContainer(for: ZikrModel.self)
            container = modelContainer
            let countService = CountService(modelContext: modelContainer.mainContext)
            _countService = State(initialValue: countService)
            launchErrorMessage = nil
        } catch {
            container = nil
            _countService = State(initialValue: nil)
            launchErrorMessage = error.localizedDescription
        }
    }
}
