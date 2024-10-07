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
    
    private let calculator = PrayerTimesCalculator(coordinate: .init(
        latitude: 55.7887, longitude: 49.1221
    ))
    
    var body: some View {
        timesView(times: times)
        .padding(.horizontal, 72)
        .onAppear {
            times = calculator.prayerTimes()
            
            for time in times {
                if time.date <= .now {
                    currentTime = time.type
                } else {
                    break
                }
            }
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
