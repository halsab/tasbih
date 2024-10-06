//
//  PrayerTimesView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 04.10.2024.
//

import SwiftUI

struct PrayerTimesView: View {
    
    @State private var times: [AKPrayerTime.TimeNames : Any]? = nil
    
    let prayerKit = AKPrayerTime(lat: 55.7887, lng: 49.1221)
    
    init() {
        prayerKit.calculationMethod = .DUMRT
        prayerKit.asrJuristic = .Hanafi
        prayerKit.outputFormat = .Time24
        prayerKit.highLatitudeAdjustment = .AngleBased
    }
    
    var body: some View {
        Group {
            if let times {
                VStack(alignment: .leading) {
                    timeView(name: "Fajr", value: times[.Fajr]!)
                    timeView(name: "Sunrise", value: times[.Sunrise]!)
                    timeView(name: "Dhuhr", value: times[.Dhuhr]!)
                    timeView(name: "Asr", value: times[.Asr]!)
                    timeView(name: "Maghrib", value: times[.Maghrib]!)
                    timeView(name: "Isha", value: times[.Isha]!)
                }
            } else {
                ProgressView()
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 96)
        .onAppear {
            times = prayerKit.getPrayerTimes()
        }
    }
    
    @ViewBuilder
    private func timeView(name: String, value: Any) -> some View {
        VStack {
            HStack {
                Text(name)
                Spacer()
                Text("\(value)")
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
