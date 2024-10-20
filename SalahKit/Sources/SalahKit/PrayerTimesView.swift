//
//  PrayerTimesView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 04.10.2024.
//

import SwiftUI
import HelperKit
import AppUIKit
import CoreLocationUI

public struct PrayerTimesView: View {
    
    @ObservedObject private var vm = PrayerTimesViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    public init() {}
        
    public var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                timesView(times: vm.times)
                    .overlay(alignment: .bottomTrailing) {
                        Text(vm.remainingTime)
                            .monospaced()
                            .offset(.init(width: -16, height: 32))
                    }
                
            }
            .padding(.horizontal, 72)
            .onAppear {
                vm.updateTimes()
            }
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    vm.updateTimes()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button(action: vm.requestLocation) {
                            Text(vm.localeAddress)
                        }
                        .buttonStyle(CustomButtonStyle())
                        
                        if vm.isLoadingLocation {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func timeView(time: PrayerTime) -> some View {
        VStack {
            HStack {
                Text(time.type.name(.russian))
                    .font(.app.mTitle)
                Spacer()
                Text(time.date, style: .time)
                    .font(.app.mBody)
                    .monospaced()
            }
            .foregroundStyle(time.type == vm.currentTimeType ? Color.app.highlight : .primary)
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
