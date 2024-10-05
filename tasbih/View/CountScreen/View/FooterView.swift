//
//  FooterView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 26.03.2024.
//

import SwiftUI

struct FooterView: View {

    @EnvironmentObject private var cm: CountManager
    @State private var showPrayerTimes = false

    private let bounceAnimationSpeed: Double = 1.3

    var body: some View {
        HStack {
            Button {
                cm.reset()
            } label: {
                Text(String.text.button.reset)
            }
            .padding()
            .buttonStyle(CustomButtonStyle())
            
            Spacer()

            Button {
                cm.isHapticEnabled.toggle()
            } label: {
                Image(systemName: cm.isHapticEnabled ? .image.haptic.on : .image.haptic.off)
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.shape(.app.tint))

            }
            .padding(8)
            .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: cm.isHapticEnabled)
            .contentTransition(.symbolEffect(.replace))
            
            Button {
                showPrayerTimes = true
            } label: {
                Image(systemName: showPrayerTimes ? .image.prayerTimes.on : .image.prayerTimes.off)
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.shape(.app.tint))

            }
            .padding(8)
            .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: showPrayerTimes)
            .contentTransition(.symbolEffect(.replace))

            Spacer()
            
            Button {
                cm.undo()
            } label: {
                Text(String.text.button.undo)
            }
            .padding()
            .buttonStyle(CustomButtonStyle())
        }
        .sheet(isPresented: $showPrayerTimes) {
            PrayerTimesView()
                .presentationDetents([.height(300)])
        }
    }
}

#Preview {
    FooterView()
        .environmentObject(CountManager())
        .padding()
        .preferredColorScheme(.dark)
}
