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
    @Published var currentLoopCount = 0
    @Published var loopsCount = 0
    @Published var loopSize = 33

    private var anyCancellables = Set<AnyCancellable>()

    init() {
        $totalCounts
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] count in
                currentLoopCount = totalCounts % loopSize
                if count % loopSize == 0, count != 0 {
                    loopsCount += 1
                }
            }
            .store(in: &anyCancellables)
    }
}
