//
//  CountController.swift
//  Module
//
//  Created by Khalil Sabirov on 05.02.2025.
//

import SwiftUI
import SwiftData

@Observable
final class CountController {
    
    var currentLoopCount = 0
    var loopSize: LoopSize = .s
    var count = 0
    var loopsCount = 0
    var selectedZikrName: String {
        selectedZikr?.name ?? ""
    }
    var isZikrsExist: Bool {
        !zikrs.isEmpty
    }

    private var modelContext: ModelContext
    private var selectedZikr: ZikrModel?
    private var zikrs: [ZikrModel] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchZikrs()
    }
    
    func increment() {
        selectedZikr?.count += 1
        selectedZikr?.date = .now
        saveContext()
    }
    
    func decrement() {
        selectedZikr?.count -= 1
        selectedZikr?.date = .now
        saveContext()
    }
    
    func reset() {
        
    }
    
    func resetCompletly() {
        
    }
    
    func createZikr(name: String) {
        let zikr = ZikrModel(name: name)
        zikrs.forEach {
            $0.isSelected = false
        }
        modelContext.insert(zikr)
        saveContext()
        fetchZikrs()
    }
    
    private func fetchZikrs() {
        do {
            let fetchDescriptor = FetchDescriptor<ZikrModel>(sortBy: [SortDescriptor(\.name)])
            zikrs = try modelContext.fetch(fetchDescriptor)
            selectedZikr = zikrs.filter(\.isSelected).first
        } catch {
            print("Failed to fetch zikrs: \(error)")
        }
    }
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
