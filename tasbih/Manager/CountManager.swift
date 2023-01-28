//
//  CountManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine

final class CountManager: ObservableObject {
    
    @Published var count: CountType = .first
    @Published var counts: [CountType] = [.first, .second, .third]
    
    @Published private(set) var value: Int = 0
    @Published private(set) var loops: Int = 0
    @Published private(set) var total: Int = 0
    
    private var anyCancellables = Set<AnyCancellable>()
    
    init() {
        total = count.total
        $total
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] total in
                count.save(total)
                loops = total / count.loopSize
                value = total - loops * count.loopSize
                hapticFeedback()
            }
            .store(in: &anyCancellables)
        $count
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] count in
                total = count.total
            }
            .store(in: &anyCancellables)
    }
    
    func increment() {
        total += 1
    }
    
    func decrement() {
        if total > 0 {
            total -= 1
        } else {
            total = 0
        }
    }
    
    func reset() {
        total = loops * count.loopSize
    }
    
    func hardReset() {
        total = 0
    }
    
    func hardResetAll() {
        counts.forEach {
            $0.save(0)
        }
        total = 0
    }
    
    private func hapticFeedback() {
        if value == 0 {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.prepare()
            generator.impactOccurred()
        }
    }
}
