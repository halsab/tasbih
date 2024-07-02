//
//  CountManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine
import SwiftData

final class CountManager: ObservableObject {

    @Published var totalCounts = 0
    @Published var currentLoopCount = 0
    @Published var loopsCount = 0
    @Published var loopSize: LoopSize = .s

    @AppStorage(.storageKey.haptic) var isHapticEnabled = false

    private var anyCancellables = Set<AnyCancellable>()

    private let hardHapticFeedback = UINotificationFeedbackGenerator()
    private let softHapticFeedback = UIImpactFeedbackGenerator(style: .soft)

    init() {
        $totalCounts
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] count in
                currentLoopCount = totalCounts % loopSize.rawValue
                loopsCount = totalCounts / loopSize.rawValue
                hapticFeedback()
            }
            .store(in: &anyCancellables)
    }

    func reset() {
        totalCounts = 0
    }

    func undo() {
        if totalCounts > 0 {
            totalCounts -= 1
        }
    }
}

// MARK: - Feedback methods

private extension CountManager {
    func hapticFeedback() {
        guard isHapticEnabled else { return }
        if currentLoopCount == 0 {
            hardHapticFeedback.notificationOccurred(.success)
        } else {
            softHapticFeedback.impactOccurred()
            softHapticFeedback.prepare()
        }
    }
}
