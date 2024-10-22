//
//  LocationManager.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 19.10.2024.
//

import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {
    
    @Published var location: CLLocation = .init(
        latitude: 55.7887,
        longitude: 49.1221
    )
    @Published var address: Address = .init(city: nil, street: nil)
    
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    private var cancellable: AnyCancellable?
    
    override init() {
        super.init()
        
        cancellable = $location.sink { [unowned self] location in
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
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
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
        print(1)
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
    struct Address {
        let city: String?
        let street: String?
        
        var isValid: Bool {
            city != nil || street != nil
        }
    }
}