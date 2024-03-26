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

    @Published var isAutoMode = false
    @Published var isAutoPlay = false

    @Published var isDesignMode = false

    @Published var symbolName = ""

    @AppStorage("isHapticEnabled") var isHapticEnabled = false
    @AppStorage("isSoundEnabled") var isSoundEnabled = false
    @AppStorage("autoModeSpeed") var autoModeSpeed: Double = 1

    let autoModeSpeedRange: ClosedRange<Double> = 1...10

    private let manualSymbolName = "suit.heart.fill"
    private let autoPlaySymbolName = "play.fill"
    private let autoStopSymbolName = "pause.fill"

    private var anyCancellables = Set<AnyCancellable>()

    init() {
        $totalCounts
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] count in
                currentLoopCount = totalCounts % loopSize
                if count % loopSize == 0, count != 0 {
                    loopsCount += 1
                }
                hapticFeedback()
                soundFeedback()
            }
            .store(in: &anyCancellables)

        $loopSize
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] size in
                currentLoopCount = totalCounts % size
                if totalCounts % size == 0, totalCounts != 0 {
                    loopsCount += 1
                }
            }
            .store(in: &anyCancellables)

        symbolName = manualSymbolName

        $isAutoMode
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] isEnabled in
                isAutoPlay = false
            }
            .store(in: &anyCancellables)

        $isAutoPlay
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] isPlay in
                if isAutoMode {
                    symbolName = isPlay ? autoStopSymbolName : autoPlaySymbolName
                } else {
                    symbolName = manualSymbolName
                }
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
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.prepare()
            generator.impactOccurred()
        }
    }

    func soundFeedback() {
        guard isSoundEnabled else { return }
        // TODO: play sound
    }
}
