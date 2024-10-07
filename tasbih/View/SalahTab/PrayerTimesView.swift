//
//  PrayerTimesView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 04.10.2024.
//

import SwiftUI

struct PrayerTimesView: View {
    
    @State private var times: [PrayerTime] = []
    
    private let calculator = PrayerTimesCalculator(coordinate: .init(
        latitude: 55.7887, longitude: 49.1221
    ))
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(times) { time in
                timeView(time: time)
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 96)
        .onAppear {
            times = calculator.prayerTimes()
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
            .foregroundStyle(.primary)
            .font(.headline)
            
            Divider()
        }
    }
}

#Preview {
    PrayerTimesView()
}
