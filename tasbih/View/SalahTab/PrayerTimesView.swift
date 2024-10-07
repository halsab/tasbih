//
//  PrayerTimesView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 04.10.2024.
//

import SwiftUI

struct PrayerTimesView: View {
    
    @State private var times: [PrayerTime] = []
    @State private var currentTime: PrayerTimeType = .fajr
    @State private var nextTime: PrayerTime = .init(type: .fajr)
    @State private var interval: Double = 0
    @State private var remainingTime = "00:00:00"
    @State private var timer: Timer?
    
    private let calculator = PrayerTimesCalculator(coordinate: .init(
        latitude: 55.7887, longitude: 49.1221
    ))
    
    var body: some View {
        VStack(alignment: .trailing) {
            timesView(times: times)
            
            Text(remainingTime)
                .monospaced()
                .padding(.horizontal)
        }
        .padding(.horizontal, 72)
        .onAppear {
            times = calculator.prayerTimes()
            
            for time in times {
                if time.date <= .now {
                    currentTime = time.type
                } else {
                    nextTime = time
                    break
                }
            }
            
            interval = Double(nextTime.date.timeIntervalSince(.now))
            
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                if interval > 0 {
                    interval -= 1
                    
                    let rawMinutes = (interval / 60).rounded(.down)
                    let hours = (rawMinutes / 60).rounded(.down)
                    let minutes = rawMinutes.truncatingRemainder(dividingBy: 60).rounded(.down)
                    let seconds = interval.truncatingRemainder(dividingBy: 60).rounded(.down)
                    remainingTime = String(format: "%02.0f:%02.0f:%02.0f", hours, minutes, seconds)
                } else {
                    timer?.invalidate()
                    timer = nil
                }
            })
        }
    }
    
    @ViewBuilder
    private func timeView(time: PrayerTime) -> some View {
        VStack {
            HStack {
                Text(time.type.name(.russian))
                Spacer()
                Text(time.date, style: .time)
                    .monospaced()
            }
            .foregroundStyle(time.type == currentTime ? Color.app.highlight : .primary)
            .font(.headline)
        }
    }
    
    @ViewBuilder
    private func timesView(times: [PrayerTime]) -> some View {
        VStack {
            ForEach(times) { time in
                timeView(time: time)
                    .padding(.vertical, 8)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.background.secondary)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    PrayerTimesView()
}

class TimerModel: ObservableObject {
    @Published var timerString = "00:00"
    
    private var countdownTime = 60 // seconds
    private var timer: Timer?
    private var totalTime = 60
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.updateTimer()
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        pauseTimer()
        countdownTime = totalTime
        updateTimerString()
    }
    
    private func updateTimer() {
        if countdownTime > 0 {
            countdownTime -= 1
            updateTimerString()
        } else {
            pauseTimer()
        }
    }
    
    private func updateTimerString() {
        let minutes = countdownTime / 60
        let seconds = countdownTime % 60
        timerString = String(format: "%02d:%02d", minutes, seconds)
    }
}
