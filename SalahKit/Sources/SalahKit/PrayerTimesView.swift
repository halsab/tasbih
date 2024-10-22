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
            ZStack {
                GeometryReader { geometry in
                    bgView(size: geometry.size)
                }
                .ignoresSafeArea()
                
                timesView(times: vm.times)
                    .frame(width: 235)
                    .overlay(alignment: .bottomTrailing) {
                        Text(vm.remainingTime)
                            .monospaced()
                            .offset(.init(width: -16, height: 32))
                    }
            }
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
                    locationView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func locationView() -> some View {
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
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 12))
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
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16))
    }
    
    @ViewBuilder
    private func bgView(size: CGSize) -> some View {
        Group {
            Circle()
                .fill(Color.blue)
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
                .fill(Color.red)
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
                .fill(Color.purple)
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
}
