//
//  ZikrModel.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import Foundation
import SwiftData

@Model
final class ZikrModel: Identifiable {
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var name: String
    var count: Int
    var loopSize: LoopSize
    var date: Date
    var isSelected: Bool
    
    @Transient
    var currentLoopCount: Int {
        count % loopSize.rawValue
    }
    @Transient
    var loopsCount: Int {
        count / loopSize.rawValue
    }
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.count = 0
        self.loopSize = .s
        self.date = .now
        self.isSelected = true
    }
}

@MainActor
extension ZikrModel {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: ZikrModel.self, configurations: config)
            
            for i in 0..<10 {
                let zikr = ZikrModel(name: "Zikr \(i)")
                zikr.isSelected = i == 0
                container.mainContext.insert(zikr)
            }
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
    
    static let previewModel: ZikrModel = .init(name: "Preview Zikr")
}
