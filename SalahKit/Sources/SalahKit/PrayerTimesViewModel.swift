//
//  PrayerTimesViewModel.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 19.10.2024.
//

import Combine
import CoreLocation
import HelperKit
import SwiftUI
import SwiftData

@MainActor
final class PrayerTimesViewModel: ObservableObject {
    
    @Published var times: [PrayerTime] = []
    @Published var remainingTime = ""
    @Published var currentTimeType: PrayerTimeType = .fajr
    @Published var address: LocationManager.Address = .init(city: nil, street: nil)
    @Published var isLoadingLocation = false
    @Published var calculationMethod: PrayerTimesCalculator.Method = .dumRT
    
    @AppStorage(.storageKey.salah.calculationMethod) var storedCalculationMethod: PrayerTimesCalculator.Method = .dumRT
    
    private var calculator: PrayerTimesCalculator?
    private var timeManager = PrayerTimerManager()
    private var locationManager = LocationManager()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        timeManager.$currentTimeType.assign(to: &$currentTimeType)
        timeManager.$remainingTime.assign(to: &$remainingTime)
        locationManager.$address.assign(to: &$address)
        
        locationManager.$authorizationEnabled.sink { [unowned self] authorizationEnabled in
            switch (authorizationEnabled, isLoadingLocation) {
            case (false, false): break
            case (true, false): break
            case (false, true): break
            case (true, true): break
            }
        }
        .store(in: &cancellables)
        
        locationManager.$location.sink { [unowned self] location in
            guard let location else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoadingLocation = false                
            }
            updateTimes(coordinate: location.coordinate)
        }
        .store(in: &cancellables)
        
        calculationMethod = storedCalculationMethod
        $calculationMethod.sink { [unowned self] method in
            guard let coordinate = locationManager.location?.coordinate else { return }
            storedCalculationMethod = method
            calculator = .init(coordinate: coordinate, method: method)
            updateTimes()
        }
        .store(in: &cancellables)
    }
    
    func updateTimes(coordinate: CLLocationCoordinate2D? = nil) {
        if let coordinate {
            calculator = .init(coordinate: coordinate, method: calculationMethod)
            times = calculator?.prayerTimes(coordinate: coordinate) ?? []
        } else {
            times = calculator?.prayerTimes() ?? []
        }
        timeManager.setTimes(times)
    }
    
    func requestLocation() {
        isLoadingLocation = true
        locationManager.requestLocation()
    }
}
