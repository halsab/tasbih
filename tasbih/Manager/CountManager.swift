//
//  CountManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine
import AVFoundation

final class CountManager: ObservableObject {

    @Published var totalCounts = 0
    @Published var currentLoopCount = 0
    @Published var loopsCount = 0
    @Published var loopSize: LoopSize = .s

    @AppStorage(.storageKey.haptic) var isHapticEnabled = false
    @AppStorage(.storageKey.sound) var isSoundEnabled = false

    private var player: AVAudioPlayer?
    private var anyCancellables = Set<AnyCancellable>()

    init() {
        $totalCounts
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] count in
                currentLoopCount = totalCounts % loopSize.rawValue
                if count % loopSize.rawValue == 0, count != 0 {
                    loopsCount += 1
                }
                hapticFeedback()
                soundFeedback()
            }
            .store(in: &anyCancellables)

        $loopSize
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] size in
                currentLoopCount = totalCounts % size.rawValue
                if totalCounts % size.rawValue == 0, totalCounts != 0 {
                    loopsCount += 1
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
        playSound()
    }
}

// MARK: - Sound Effect

private extension CountManager {
    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "click-tick", withExtension: "wav") else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Failed to load the sound: \(error)")
        }
        player?.play()
    }
}
