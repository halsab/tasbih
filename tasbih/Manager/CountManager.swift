//
//  CountManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine

final class CountManager: ObservableObject {

    @Published var totalCounts = 0
    @Published var loopsCount = 0
    @Published var loopSize = 33

    // MARK: Init
    
    init() {
        
    }
}

// MARK: - Internal Methods
 
extension CountManager {

}


// MARK: - Private Helpers

private extension CountManager {

}
