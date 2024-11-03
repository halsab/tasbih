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
        ZStack {
            GeometryReader { geometry in
                bgView(size: geometry.size)
            }
            .ignoresSafeArea()
            
            VStack {
                locationView()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                timesView(times: vm.times)
                
                Text(vm.remainingTime)
                    .contentTransition(.numericText())
                    .monospaced()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(width: 235)
        }
        .onAppear {
            vm.updateTimes()
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                vm.updateTimes()
            }
        }
    }
    
    @ViewBuilder
    private func locationView() -> some View {
        HStack {
            Button(action: vm.requestLocation) {
                VStack(alignment: .leading) {
                    if let city = vm.address.city {
                        Text(city)
                            .foregroundStyle(Color.primary)
                            .font(.app.font(.m))
                    }
                    
                    if let street = vm.address.street {
                        Text(street)
                            .foregroundStyle(Color.secondary)
                            .font(.app.font(.xs))
                    }
                }
                .lineLimit(1)
            }
            
            
            if vm.isLoadingLocation {
                Spacer()
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func timeView(time: PrayerTime) -> some View {
        VStack {
            HStack {
                Text(time.type.name(.russian))
                    .font(.app.font(.m, .bold))
                Spacer()
                Text(time.date, style: .time)
                    .font(.app.font(.m))
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
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16))
    }
    
    @ViewBuilder
    private func bgView(size: CGSize) -> some View {
        Group {
            Circle()
                .fill(Color.app.highlight)
                .frame(width: 200, height: 200)
                .position(
                    .init(
                        x: 50,
                        y: 170
                    )
                )
                .opacity(0.5)
                .blur(radius: 20)
            
            Circle()
                .fill(Color.secondary)
                .frame(width: 200, height: 200)
                .position(
                    .init(
                        x: (size.width / 2) + 100,
                        y: (size.height / 2) - 50
                    )
                )
                .opacity(0.5)
                .blur(radius: 20)
            
            Circle()
                .fill(Color.app.tint)
                .frame(width: 200, height: 200)
                .position(
                    .init(
                        x: (size.width / 2) - 80,
                        y: (size.height / 2) + 170
                    )
                )
                .opacity(0.5)
                .blur(radius: 20)
        }
    }
}

#Preview {
    PrayerTimesView()
        .tint(.app.tint)
}
