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

    private var selectedZikr: ZikrModel?
    private var zikrs: [ZikrModel] = []
    
    init() {
        
    }
    
    func increment() {
        
    }
    
    func decrement() {
        
    }
    
    func reset() {
        
    }
    
    func resetCompletly() {
        
    }
    
    func createZikr(name: String) {
        
    }
}
