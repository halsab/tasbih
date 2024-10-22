//
//  PrayerTimerManager.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 18.10.2024.
//

import Foundation

@MainActor
final class PrayerTimerManager: ObservableObject {
    @Published var remainingTime = ""
    @Published var currentTimeType: PrayerTimeType = .fajr
    
    private var times: [PrayerTime] = []
    private var nextTime: PrayerTime = .init(type: .sunrise)
    private var timer: Timer?
    
    init() {
        Task { @MainActor [weak self] in
            self?.timer = .scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                Task { @MainActor in
                    self?.fireTimer()
                }
            }
        }
    }
    
    deinit {
        Task { @MainActor [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
        }
    }
    
    func setTimes(_ times: [PrayerTime]) {
        self.times = times
        timer?.fire()
    }
    
    @MainActor
    private func fireTimer() {
        guard !times.isEmpty else { return }
        
        for time in times {
            if time.date <= .now {
                currentTimeType = time.type
            } else {
                nextTime = time
                break
            }
        }
        
        var interval = Double(nextTime.date.timeIntervalSince(.now))
        
        if currentTimeType == times.last?.type,
           let firstTime = times.first,
           let nextTimeDate = Calendar.current.date(byAdding: .day, value: 1, to: firstTime.date) {
            interval = Double(nextTimeDate.timeIntervalSince(.now))
        }
        
        guard interval > 0 else {
            remainingTime = ""
            return
        }
        
        let rawMinutes = (interval / 60).rounded(.down)
        let hours = (rawMinutes / 60).rounded(.down)
        let minutes = rawMinutes.truncatingRemainder(dividingBy: 60).rounded(.down)
        let seconds = interval.truncatingRemainder(dividingBy: 60).rounded(.down)
        remainingTime = String(format: "%02.0f:%02.0f:%02.0f", hours, minutes, seconds)
    }
}
