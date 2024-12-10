//
//  LocationManager.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 19.10.2024.
//

import CoreLocation
import Combine
import HelperKit
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    
    @Published var location: CLLocation?
    @Published var address: Address = .init(city: nil, street: nil)
    
    @AppStorage(.storageKey.salah.lastLatitude) private var lastLatitude: Double?
    @AppStorage(.storageKey.salah.lastLongitude) private var lastLongitude: Double?
    
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    private var cancellable: AnyCancellable?
    
    override init() {
        super.init()
                
        cancellable = $location.sink { [unowned self] location in
            guard let location else { return }
            lastLatitude = location.coordinate.latitude
            lastLongitude = location.coordinate.longitude
            getAddress(from: location) { address in
                if address.isValid {
                    self.address = address
                } else {
                    let latitude = String(format: "%.4f", location.coordinate.latitude)
                    let longitude = String(format: "%.4f", location.coordinate.longitude)
                    self.address = .init(city: nil, street: "\(latitude), \(longitude)")
                }
            }
        }
        
        if let lastLatitude, let lastLongitude {
            location = CLLocation(latitude: lastLatitude, longitude: lastLongitude)
        }
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
}

// MARK: - Helpers

private extension LocationManager {
    func getAddress(from location: CLLocation, completion: @escaping (Address) -> Void) {
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US")) { (placemarks, error) in
            guard error == nil, let placemark = placemarks?.first else {
                print("Reverse geocoding error: \(error!)")
                completion(.init(city: nil, street: nil))
                return
            }
            completion(.init(city: placemark.locality, street: placemark.thoroughfare))
        }
    }

}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                manager.requestLocation()
            default:
                print("locationManagerDidChangeAuthorization \(manager.authorizationStatus)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("locationManager didFailWithError: \(error)")
    }
}

// MARK: - Address

extension LocationManager {
    struct Address: Codable {
        let city: String?
        let street: String?
        
        var isValid: Bool {
            city != nil || street != nil
        }
    }
}
