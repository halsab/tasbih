//
//  PrayerTimesViewModel.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 19.10.2024.
//

import Combine
import CoreLocation

@MainActor
final class PrayerTimesViewModel: ObservableObject {
    
    @Published var times: [PrayerTime] = []
    @Published var remainingTime = ""
    @Published var currentTimeType: PrayerTimeType = .fajr
    @Published var address: LocationManager.Address = .init(city: nil, street: nil)
    @Published var isLoadingLocation = false
    
    private let calculator = PrayerTimesCalculator(coordinate: .init(
        latitude: 55.7887, longitude: 49.1221
    ))
    
    private var timeManager = PrayerTimerManager()
    private var locationManager = LocationManager()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        timeManager.$currentTimeType.assign(to: &$currentTimeType)
        timeManager.$remainingTime.assign(to: &$remainingTime)
        locationManager.$address.assign(to: &$address)
        
        locationManager.$location.sink { [unowned self] location in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoadingLocation = false                
            }
            updateTimes(coordinate: location.coordinate)
        }
        .store(in: &cancellables)
    }
    
    func updateTimes(coordinate: CLLocationCoordinate2D? = nil) {
        if let coordinate {
            times = calculator.prayerTimes(coordinate: coordinate)
        } else {
            times = calculator.prayerTimes()
        }
        timeManager.setTimes(times)
    }
    
    func requestLocation() {
        isLoadingLocation = true
        locationManager.requestLocation()
    }
}
