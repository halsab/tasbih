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
                loopsCount = totalCounts / loopSize.rawValue
                hapticFeedback()
                soundFeedback()
            }
            .store(in: &anyCancellables)

        if let soundURL = Bundle.main.url(forResource: "click-tick", withExtension: "wav") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print("Failed to load the sound: \(error)")
            }
        }
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
//        guard isSoundEnabled else { return }
//        playSound()
    }
}

// MARK: - Sound Effect

private extension CountManager {
    func playSound() {
        #warning("Fix bug. Sound playing only in headphones")
        DispatchQueue.global().async {
            self.player?.play()
        }
    }
}
