//
//  PrayerTimesView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 04.10.2024.
//

import SwiftUI
import HelperKit
import AppUIKit

public struct PrayerTimesView: View {
    
    @StateObject private var timeManager = PrayerTimerManager()
    @Environment(\.scenePhase) var scenePhase
    @State private var times: [PrayerTime] = []

    private let calculator = PrayerTimesCalculator(coordinate: .init(
        latitude: 55.7887, longitude: 49.1221
    ))
    
    public init() {}
        
    public var body: some View {
        VStack(alignment: .trailing) {
            timesView(times: times)
                .overlay(alignment: .bottomTrailing) {
                    Text(timeManager.remainingTime)
                        .monospaced()
                        .offset(.init(width: -16, height: 32))
                }
            
        }
        .padding(.horizontal, 72)
        .onAppear {
            updateTimes()
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                updateTimes()
            }
        }
    }
    
    private func updateTimes() {
        times = calculator.prayerTimes()
        timeManager.setTimes(times)
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
            .foregroundStyle(time.type == timeManager.currentTimeType ? Color.app.highlight : .primary)
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
